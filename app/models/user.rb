# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts
  has_many :comments
  # has_many :user_follows

  validates :email, :password, :nickname, :phone, presence: true

  def user_follows
    UserFollow.where(follower: self)
  end

  def self.search(search)
    if search
      where('nickname LIKE ?', "%#{search}%")
    else
      User.all
    end
  end
end
