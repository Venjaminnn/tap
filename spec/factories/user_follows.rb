# frozen_string_literal: true

FactoryBot.define do
  factory :user_follow do
    association(:following)
    association(:follower)
  end
end
