# frozen_string_literal: true

class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
    json_response(@transactions)
  end

  def show
    json_response(Transaction.find(params[:id]))
  end
end
