# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Comments', type: :feature do
  let!(:post) { create(:post) }
  let!(:current_user) { create(:user, password: 'password') }
  let!(:comments) { create_list(:comment, 3, post: post, user: current_user) }

  # context 'multiply sessions' do
  #   scenario 'create message vision for all', js: true do

  #     Capybara.using_session('current_user') do
  #       sign_in(current_user)
  #       visit feed_path

  #       expect(page).to have_content 'Comments'
  #     end
  #   end
  # end

  # it "displays a list of comments" do
  #   comments.each do |comment|
  #     expect(page).to have_selector("#list li#comment-#{comment.id}", text: comment.text)
  #     if comment.user == current_user
  #       expect(page).to have_selector("li#comment-#{comment.id} .delete-button")
  #     else
  #       expect(page).not_to have_selector("li#comment-#{comment.id} .delete-button")
  #     end
  #   end
  # end
  #
  # it "displays 'No comments yet.' message if there are no comments" do
  #   post.comments.destroy_all
  #   visit post_comments_path(post)
  #   expect(page).to have_content("No comments yet.")
  # end
  #
  # it "allows adding a comment" do
  #   new_comment_text = "This is a new comment"
  #   fill_in "Your comment", with: new_comment_text
  #   click_on "Add Comment"
  #   expect(page).to have_selector("#list li", count: comments.count + 1)
  #   expect(page).to have_selector("#list li", text: new_comment_text)
  # end
end