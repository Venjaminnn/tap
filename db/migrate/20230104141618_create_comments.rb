# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true, null: false
      t.references :post, foreign_key: true, null: false
      t.string :text, null: false

      t.timestamps
    end
  end
end
