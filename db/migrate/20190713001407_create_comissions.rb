# frozen_string_literal: true

class CreateComissions < ActiveRecord::Migration[5.2]
  def change
    create_table :comissions do |t|
      t.decimal :lower_limit
      t.decimal :upper_limit
      t.decimal :percentage
      t.decimal :fixed

      t.timestamps
    end
  end
end
