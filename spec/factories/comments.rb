# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    user
    post
    text { 'my new comment' }
  end
end
