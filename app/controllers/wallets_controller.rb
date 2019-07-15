# frozen_string_literal: true

class WalletsController < ApplicationController
  # GET /wallets
  def index
    @wallets = Wallet.all
    json_response(@wallets)
  end

  # GET /wallets/:id
  def show
    json_response(Wallet.find(params[:id]))
  end
end
