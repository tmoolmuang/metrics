require 'rails_helper'

RSpec.describe "App", :type => feature do

  feature 'View registered applications' do        
    let(:test_user) { create(:user) }
      
    scenario 'allows a registered user to view the list of applications' do
      visit new_user_session_path
      fill_in "user_email", :with => test_user.email
      fill_in "user_password", :with => test_user.password
      click_button "Sign in"
      visit myapps_apps_path
      expect(page).to have_content 'My Registered Applications'
    end
  end
  
  feature 'Register new application' do        
    let(:test_user) { create(:user) }
    let(:test_app) { create(:app) }
    let(:edited_test_app) { create(:app) }
      
    scenario 'allows a registered user to add new application' do
      visit new_user_session_path
      fill_in "user_email", :with => test_user.email
      fill_in "user_password", :with => test_user.password
      click_button "Sign in"
      visit new_app_path
      fill_in 'app_name', :with => test_app.name
      fill_in 'app_url', :with => test_app.url
      click_on 'Save'
      expect(page).to have_content 'Application was registered successfully'
    end
    
    scenario 'allows a registered user to edit application' do
      visit new_user_session_path
      fill_in "user_email", :with => test_user.email
      fill_in "user_password", :with => test_user.password
      click_button "Sign in"
      visit new_app_path
      fill_in 'app_name', :with => test_app.name
      fill_in 'app_url', :with => test_app.url
      click_on 'Save'
      visit edit_app_path test_app.id
      fill_in 'app_name', :with => edited_test_app.name
      fill_in 'app_url', :with => edited_test_app.url
      click_on 'Save'
      expect(page).to have_content 'Application was updated successfully'
    end
    
    scenario 'allows a registered user to cancel out from add new application' do
      visit new_user_session_path
      fill_in "user_email", :with => test_user.email
      fill_in "user_password", :with => test_user.password
      click_button "Sign in"
      visit new_app_path
      fill_in 'app_name', :with => test_app.name
      fill_in 'app_url', :with => test_app.url
      click_on 'Cancel'
      expect(page).to have_content 'My Registered Applications'
    end
  end
  
  feature 'Delete registered applications' do        
    let(:test_user) { create(:user) }
    let(:test_app) { create(:app) }
      
    scenario 'allows a registered user to delete application' do
      visit new_user_session_path
      fill_in "user_email", :with => test_user.email
      fill_in "user_password", :with => test_user.password
      click_button "Sign in"
      visit new_app_path
      fill_in 'app_name', :with => test_app.name
      fill_in 'app_url', :with => test_app.url
      click_on 'Save'
      click_on 'Delete Application'
      expect(page).to have_content 'deleted successfully'
    end
  end
end