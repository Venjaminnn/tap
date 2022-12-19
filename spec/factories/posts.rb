# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    user
    image { Rack::Test::UploadedFile.new('spec/fixtures/files/image.jpg', 'image/jpg') }
    comment { 'my new post' }
    likes_count { 1 }
  end
end
