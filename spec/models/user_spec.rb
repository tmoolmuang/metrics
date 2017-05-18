require 'rails_helper'

RSpec.describe User, type: :model do
  let(:test_user) { create(:user) }

  describe "attributes" do
    it "has name, email, and password attributes" do
      expect(test_user).to have_attributes(name: test_user.name, email: test_user.email, password: test_user.password)
    end
  end

end