# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts 'Creating seed'
user = User.create(nickname: 'TestUser', phone: '+198327941501', password: 'test_password', email: 'hello@mail.com')
second_user = User.create(nickname: 'SecondUser', phone: '+898327941501', password: 'second_password',
                          email: 'hello2@mail.com')
number = rand(1..10)
word = 'Enim molestiae incidunt rem ipsum perferendis beatae excepturi tenetur.'
number.times do |_|
  user.posts.create(image: Rack::Test::UploadedFile.new('spec/fixtures/files/image.jpg', 'image/jpg'),
                    comment: word.split('').shuffle.join)
end
number2 = rand(1..10)
number2.times do |_|
  second_user.posts.create(image: Rack::Test::UploadedFile.new('spec/fixtures/files/image.jpg', 'image/jpg'),
                    comment: word.split('').shuffle.join)
end