# frozen_string_literal: true

class TransactionsController < ApplicationController
  def index
    # @transactions = Transaction.all
    @transactions = current_user.wallet.wallet_origin_transaction
    @transactions += current_user.wallet.wallet_destiny_transaction
    json_response(@transactions)
  end

  def show
    @transaction = Transaction.find(params[:id])
    if @transaction &&
       @transaction.wallet_origin.user == current_user ||
       @transaction.wallet_destiny.user == current_user
        json_response(@transaction)
    else
      json_response({ error: 'Not found' }, :not_found)
    end
  end

  # POST /transactions
  def create
    @transaction = Transaction.new(trans_params)
    if @transaction.valid?
      amount = @transaction.amount
      @transaction.percentage = transaction_percentage(amount)
      @transaction.fixed = transaction_fixed(amount)

      # wallet -> wallet
      if @transaction.wallet_origin && @transaction.wallet_destiny
        @res = wallet_to_wallet

      # wallet -> debit
      elsif @transaction.wallet_origin && @transaction.card_destiny
        @res = wallet_to_card

      # card -> wallet
      else @transaction.card_origin && @transaction.wallet_destiny
        @res = card_to_wallet
      end
    end

    return json_response(@transaction, :ok) if @res
    json_response({ error: @transaction.errors.full_messages.to_sentence }, :unprocessable_entity)
  end

  private

  def card_to_wallet
    if @transaction.wallet_destiny.user == current_user
      @full_amount = full_amount(@transaction.amount)

      admin_user.wallet.balance += @full_amount - @transaction.amount
      current_user.wallet.balance += @transaction.amount

      if CardCallback.simulate(@transaction.card_origin.number)
        return current_user.wallet.save && admin_user.wallet.save
      end
    end
    false
  end

  def wallet_to_card
    if @transaction.wallet_origin.user == current_user
      @full_amount = full_amount(@transaction.amount)
      if balance_ok
        admin_user.wallet.balance += @full_amount - @transaction.amount
        @transaction.wallet_origin.balance -= @full_amount

        if CardCallback.simulate(@transaction.card_destiny.number)
          return current_user.wallet.save && admin_user.wallet.save
        end
      end
    end
    false
  end

  def wallet_to_wallet
    if @transaction.wallet_origin.user == current_user
      @full_amount = full_amount(@transaction.amount)
      if balance_ok
        admin_user.wallet.balance += @full_amount - @transaction.amount
        @transaction.wallet_origin.balance -= @full_amount
        @transaction.wallet_destiny.balance += @transaction.amount
        return @transaction.wallet_destiny.save &&
               @transaction.wallet_origin.save &&
               admin_user.wallet.save
      end
    end
    false
  end

  def balance_ok
    @transaction.wallet_origin.balance > @full_amount
  end

  # calculate amount to be payer with comissions
  def full_amount(amount)
    amount + transaction_fixed(amount) + amount*(transaction_percentage(amount)/100)
  end

  def transaction_percentage(amount)
    result = case amount
             when 0..1000 then 3.0
             when 1001..5000 then 2.5
             when 5001..10_000 then 2.0
             else 1.0
             end
  end

  def transaction_fixed(amount)
    result = case amount
             when 0..1000 then 8.0
             when 1001..5000 then 6.5
             when 5001..10_000 then 4.0
             else 3.0
             end
  end

  def valid_wallet(wallet_id)
    Wallet.find(wallet_id).id == wallet_id
  end

  def trans_params
    params.permit(
      :wallet_origin_id,
      :wallet_destiny_id,
      :card_origin_id,
      :card_destiny_id,
      :amount
    )
  end
end
