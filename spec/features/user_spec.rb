require 'rails_helper'

RSpec.describe "User", :type => feature do
  let(:unconfirmed_user) { create(:user) }
  let(:std_user) { create(:user, confirmed_at: DateTime.now) }
  let(:admin_user) { create(:user, role: :admin, confirmed_at: DateTime.now) }

  feature 'Sign up' do
    scenario 'allows a user to register' do
      visit new_user_registration_path
      fill_in 'user_email', :with => 'newuser@example.com'
      fill_in 'user_password', :with => 'userpassword'
      fill_in 'user_password_confirmation', :with => 'userpassword'
      click_on 'Sign up'
      expect(page).to have_content 'A message with a confirmation link has been sent to your email address.'
    end
  end

  feature "Sign in" do
    scenario "with unknown user" do
      visit new_user_session_path
      fill_in "user_email", :with => "hacker@test.com"
      fill_in "user_password", :with => "123abc"
      click_button "Sign in"
      expect(page).to have_content("Invalid")
    end

    scenario "with unconfirmed user" do
      visit new_user_session_path
      fill_in "user_email", :with => unconfirmed_user.email
      fill_in "user_password", :with => unconfirmed_user.password
      click_button "Sign in"
      expect(page).to have_content("You have to confirm your email address before continuing")
    end

    scenario "with standard user" do
      visit new_user_session_path
      fill_in "user_email", :with => std_user.email
      fill_in "user_password", :with => std_user.password
      click_button "Sign in"
      expect(page).to have_content("Signed in successfully")
    end

    scenario "with admin user" do
      visit new_user_session_path
      fill_in "user_email", :with => admin_user.email
      fill_in "user_password", :with => admin_user.password
      click_button "Sign in"
      expect(page).to have_content 'All Applications'
    end
  end
  
  feature "Edit user" do
    scenario "allows registered user to view edit user info" do
      login_as(std_user)
      visit edit_user_registration_path
      expect(page).to have_content("we need your current password to confirm your changes")
    end

    scenario "allows registered user to edit name" do
      login_as(std_user)
      visit edit_user_registration_path
      fill_in "user_name", :with => "New Name"
      fill_in "user_current_password", :with => std_user.password
      click_button "Update"
      expect(page).to have_content("Your account has been updated successfully")
    end

    scenario "not allows registered user with wrong password to edit name" do
      login_as(std_user)
      visit edit_user_registration_path
      fill_in "user_name", :with => "New Name"
      fill_in "user_current_password", :with => "qwert"
      click_button "Update"
      expect(page).to have_content("Current password is invalid")
    end

    scenario "allows registered user to change password" do
      login_as(std_user)
      visit edit_user_registration_path
      fill_in "user_password", :with => "123abc"
      fill_in "user_password_confirmation", :with => "123abc"
      fill_in "user_current_password", :with => std_user.password
      click_button "Update"
      expect(page).to have_content("Your account has been updated successfully")
    end

    scenario "not allow registered user to change password with wrong current password" do
      login_as(std_user)
      visit edit_user_registration_path
      fill_in "user_password", :with => "123abc"
      fill_in "user_password_confirmation", :with => "123abc"
      fill_in "user_current_password", :with => "qwert"
      click_button "Update"
      expect(page).to have_content("Current password is invalid")
    end
  end
end