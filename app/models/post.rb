# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  belongs_to :user

  has_one_attached :image, dependent: :destroy

  validates :image, presence: true
  validates :likes_count, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def like
    update!(likes_count: self.likes_count += 1)
  end

  def dislike
    update!(likes_count: self.likes_count -= 1)
  end

  def liked_by?(user)
    likes.where(user: user).present?
  end
end
