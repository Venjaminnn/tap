# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments

  belongs_to :user

  has_one_attached :image, dependent: :destroy

  validates :image, presence: true
end
