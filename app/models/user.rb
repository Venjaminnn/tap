# frozen_string_literal: true

class User < ApplicationRecord
  validate :email, :password, :nickname, :phone, presence: true
end
