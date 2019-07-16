# frozen_string_literal: true

class WalletsController < ApplicationController
  # GET /wallets
  def index
    # @wallets = Wallet.all
    @wallets = current_user.wallet
    json_response(@wallets)
  end

  # GET /wallets/:id
  def show
    json_response(Wallet.find(params[:id])) if current_user.wallet.id.to_s == params[:id]
  end
end
