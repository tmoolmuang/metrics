require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:my_user) { create(:user, confirmed_at: DateTime.now) }
  let(:my_app) { create(:app, user: my_user) }
  let(:my_event) { create(:event, app: my_app) }
 
  it { is_expected.to belong_to(:app) }
  
  describe "attributes" do
    it "has name attribute" do
      expect(my_event).to have_attributes(name: my_event.name)
    end
  end
end
