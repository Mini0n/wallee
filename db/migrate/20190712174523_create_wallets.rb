# frozen_string_literal: true

class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.decimal :balance, default: 0.0

      t.timestamps
    end
  end
end
