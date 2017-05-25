require 'rails_helper'

RSpec.describe "User", :type => feature do

  feature 'Sign up' do
    scenario 'allows a user to register' do
      visit new_user_registration_path
      fill_in 'user_email', :with => 'newuser@example.com'
      fill_in 'user_password', :with => 'userpassword'
      fill_in 'user_password_confirmation', :with => 'userpassword'
      click_on 'Sign up'
      expect(page).to have_content 'Welcome!'
    end
  end

  feature "Sign in" do
    let(:std_user) { create(:user) }

    scenario "with registered user" do
      login_as(std_user)
      expect(page).to have_content("Signed in successfully")
    end

    scenario "with unknown user" do
      visit new_user_session_path
      fill_in("user_email", :with => "standard@test.com")
      fill_in("user_password", :with => "123qwe")
      click_on "Sign in"
      expect(page).to have_content("Invalid")
    end

  end
end