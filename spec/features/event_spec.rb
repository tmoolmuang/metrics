require 'rails_helper'

RSpec.describe "Event", :type => feature do
  let(:admin_user) { create(:user, role: :admin, confirmed_at: DateTime.now) }
  let(:std_user) { create(:user, confirmed_at: DateTime.now) }
  let(:other_std_user) { create(:user, confirmed_at: DateTime.now) }
  let(:test_app) { create(:app, user: std_user) }
  let(:test_event) { create(:event, app: test_app) }

  feature 'Create event' do        
    scenario 'not allow guest to create event' do
      login_as(std_user)
      create_app
      click_on 'Sign Out'
      visit app_path(id: '1')
      expect(page).to have_no_content "New Event"
    end

    scenario 'allows user to create event on his/her own application' do
      login_as(std_user)
      create_app
      create_event
      expect(page).to have_content "Event was created successfully"
    end

    scenario 'not allow user to create event on application he/she does not own' do
      login_as(std_user)
      create_app
      click_on 'Sign Out'
      login_as(other_std_user)
      visit new_app_event_path(app_id: '1')
      fill_in 'event_name', :with => test_event.name
      click_on 'Save'
      expect(page).to have_content "Unauthorized: not an application owner"
    end

    scenario 'allows admin to create event on any application' do
      login_as(std_user)
      create_app
      click_on 'Sign Out'
      login_as(admin_user)
      create_event
      expect(page).to have_content "Event was created successfully"
    end
  end
  
  feature 'View event' do     
    scenario 'allows anyone to view demo events' do
      login_as(admin_user)
      create_app
      create_event
      click_on 'Sign Out'
      visit app_event_path(app_id: '1', id: '1')
      expect(page).to have_no_content "New Event"
    end
  end

  feature 'Edit event' do     
    scenario 'allows event owner to edit his/her event' do
      login_as(std_user)
      create_app
      create_event
      visit app_event_path(app_id: '1', id: '1')
      click_on 'Edit Event'
      fill_in 'event_name', :with => "new event"
      click_on 'Save'
      expect(page).to have_content "Event was updated successfully"
    end

    scenario 'not allow user to edit event he/she does not own' do
      login_as(std_user)
      create_app
      create_event
      click_on 'Sign Out'
      login_as(other_std_user)
      visit edit_app_event_path(app_id: '1', id: '1')
      fill_in 'event_name', :with => "new event"
      click_on 'Save'
      expect(page).to have_content "Unauthorized: not an event owner"
    end

    scenario 'allows admin to edit any event' do
      login_as(std_user)
      create_app
      create_event
      click_on 'Sign Out'
      login_as(admin_user)
      visit app_event_path(app_id: '1', id: '1')
      click_on 'Edit Event'
      fill_in 'event_name', :with => "new event"
      click_on 'Save'
      expect(page).to have_content "Event was updated successfully"
    end
  end
  
  feature 'Delete event' do        
    scenario 'allows a registered user to delete his/her event' do
      login_as(std_user)
      create_app
      create_event
      visit app_event_path(app_id: '1', id: '1')
      click_on 'Delete Event'
      expect(page).to have_content 'deleted successfully'
    end
    
    scenario 'not allow user to delete event he/she does not own' do
      login_as(std_user)
      create_app
      create_event
      click_on 'Sign Out'
      login_as(other_std_user)
      visit app_event_path(app_id: '1', id: '1')
      expect(page).to have_no_content 'Delete Event'
    end

    scenario 'allows admin to delete any event' do
      login_as(std_user)
      create_app
      create_event
      click_on 'Sign Out'
      login_as(admin_user)
      visit app_event_path(app_id: '1', id: '1')
      click_on 'Delete Event'
      expect(page).to have_content 'deleted successfully'
    end
  end

  private
  def create_app
      visit myapps_apps_path
      click_on "New Application"
      fill_in 'app_name', :with => test_app.name
      fill_in 'app_url', :with => test_app.url
      click_on 'Save'  
  end
  
  def create_event
    visit app_path(id: '1')
    click_on 'New Event'
    fill_in 'event_name', :with => test_event.name
    click_on 'Save'
  end
end