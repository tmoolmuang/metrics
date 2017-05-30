require 'rails_helper'

RSpec.describe "App", :type => feature do
  let(:std_user) { create(:user, confirmed_at: DateTime.now) }
  let(:admin_user) { create(:user, role: :admin, confirmed_at: DateTime.now) }
  let(:test_app) { create(:app, user: std_user) }
  let(:edited_test_app) { create(:app, user: std_user) }

  feature 'View applications' do        
    scenario 'allows anyone to view demo applications' do
      visit demoapps_apps_path
      expect(page).to have_content 'by admin'
    end

    scenario 'allows a registered user to view the list of his or her own applications' do
      login_as(std_user)
      visit myapps_apps_path
      expect(page).to have_content 'My Registered Applications'
    end
    
    scenario 'allows admin to view the list of all applications' do
      login_as(admin_user)
      visit apps_path
      expect(page).to have_content 'All Applications'
    end
  end
  
  feature 'Register new application' do        
    scenario 'allows a registered user to add new application' do
      login_as(std_user)
      visit new_app_path
      fill_in 'app_name', :with => test_app.name
      fill_in 'app_url', :with => test_app.url
      click_on 'Save'
      expect(page).to have_content 'Application was registered successfully'
    end
    
    scenario 'not allow guest to add new application' do
      visit root_path
      expect(page).to have_no_content 'My Applications'
    end

    scenario 'allows a registered user to edit application' do
      login_as(std_user)
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
      login_as(std_user)
      visit new_app_path
      fill_in 'app_name', :with => test_app.name
      fill_in 'app_url', :with => test_app.url
      click_on 'Cancel'
      expect(page).to have_content 'My Registered Applications'
    end
  end
  
  feature 'Delete registered applications' do        
    scenario 'allows a registered user to delete application' do
      login_as(std_user)
      visit new_app_path
      fill_in 'app_name', :with => test_app.name
      fill_in 'app_url', :with => test_app.url
      click_on 'Save'
      click_on 'Delete Application'
      expect(page).to have_content 'deleted successfully'
    end
  end
end