# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, :password, :nickname, :phone, presence: true
end
