# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :email, :password, :nickname, :phone, presence: true

  def user_follows
    UserFollow.where(follower: self)
  end

  def self.search(search, current_user)
    if search.present?
      where('nickname LIKE ?', "%#{search.downcase}%").where.not(id: current_user.id)
    else
      User.all.where.not(id: current_user.id)
    end
  end
end
