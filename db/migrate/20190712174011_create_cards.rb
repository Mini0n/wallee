class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :name_on_card
      t.string :number
      t.date :expiry
      t.boolean :debit

      t.timestamps
    end
  end
end
