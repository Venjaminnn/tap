# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts

  validates :email, :password, :nickname, :phone, presence: true
end
