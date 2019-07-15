# frozen_string_literal: true

class CardsController < ApplicationController
  # GET /cards
  def index
    @cards = current_user.cards
    json_response(@cards)
  end

  # POST /cards
  def create
    @card = Card.new(card_params)
    if @card.valid?
      @card = Card.create!(card_params)
      @card.update(user: current_user)
      json_response(@card, :created)
    else
      json_response({ error: @card.errors.full_messages.to_sentence }, :unprocessable_entity)
    end
  end

  # GET /cards/:id
  def show
    json_response(Card.find(params[:id]))
  end

  # PUT /cards/:id
  def update
    if Card.find(params[:id]).update(card_params)
      head :ok
    else
      json_response({ error: 'Invalid data' }, :unprocessable_entity)
    end
  end

  # DELETE /cards/:id
  def destroy
    Card.find(params[:id]).destroy!
    head :ok
  end

  private

  def card_params
    params.permit(:name, :name_on_card, :number, :expiry, :debit)
  end
end
