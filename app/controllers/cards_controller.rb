# frozen_string_literal: true

class CardsController < ApplicationController
  # GET /cards
  def index
    @cards = Cards.all
    json_response(@cards)
  end
end