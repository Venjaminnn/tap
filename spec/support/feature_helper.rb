# frozen_string_literal: true

module FeatureHelper
  def sign_in(user)
    visit root_path
    find('.form.login').click
    fill_in '.wrapper.form.login.Phone', with: user.phone
    fill_in '.wrapper.form.login.Password', with: user.password
    binding.pry
    click_on 'Login'
  end
end
