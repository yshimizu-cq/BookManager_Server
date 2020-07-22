require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relation" do
    it { should have_secure_password }
    it { should have_many(:books) }
  end

  describe "validation" do
    context "email" do
      let(:user) { create(:user) }

      it { should validate_presence_of(:email) }
      it { should validate_length_of(:email).is_at_most(255) }

      # it { should validate_uniqueness_of(:email).case_insensitive }だとbefore_saveの際にエラーが出るため
      it "is invalid with a duplicate email" do
        expect(user.dup).not_to be_valid
      end
    end

    context "password" do
      it { should validate_presence_of(:password) }
      it { should validate_length_of(:password).is_at_least(6) }
    end
  end
end
