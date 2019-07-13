# frozen_string_literal: true

class CardsController < ApplicationController

  # GET /cards
  def index
    @cards = Card.all
    json_response(@cards)
  end

  # POST /cards
  def create
    @card = Card.new(card_params)
    if @card.valid?
      Card.create!(card_params)
      json_response(@card, :created)
    else
      json_response({error: @card.errors.full_messages.to_sentence}, :unprocessable_entity)
    end
  end

  # GET /cards/:id
  def show
    json_response(Card.find(params[:id]))
  end

  private

  def card_params
    params.permit(:name, :name_on_card, :number, :expiry, :debit)
  end

  # def set_card
  #   @card = Card.find(params[:id])
  # end
end
