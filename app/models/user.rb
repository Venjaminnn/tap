# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts
  has_many :comments

  validates :email, :password, :nickname, :phone, presence: true

  def user_follows
    UserFollow.where(follower: self)
  end

  def self.search(search, current_user)
    if search
      where('nickname LIKE ?', "%#{search}%").where.not(id: current_user.id)
    else
      User.all.where.not(id: current_user.id)
    end
  end
end
