class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :wallet_origin
      t.references :wallet_destiny
      t.references :card_origin
      t.references :card_destiny
      t.decimal :amount
      t.decimal :percentage
      t.decimal :fixed

      t.timestamps
    end
  end
end
