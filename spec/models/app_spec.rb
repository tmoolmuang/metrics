require 'rails_helper'

RSpec.describe App, type: :model do
  let(:my_app) { create(:app) }
  it { is_expected.to belong_to(:user) }
  
  describe "attributes" do
    it "has name and url attributes" do
      expect(my_app).to have_attributes(name: my_app.name, url: my_app.url)
    end
  end
end
