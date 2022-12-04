# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :phone, null: false
      t.string :nickname, null: false
      t.string :password, null: false

      t.timestamps
    end
  end
end
