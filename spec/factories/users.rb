# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'hello@mail.com' }
    password { 'test_password' }
    phone { '+198327941501' }
    nickname { 'Nick' }
  end
end
