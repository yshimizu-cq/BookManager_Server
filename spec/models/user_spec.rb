require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "validation" do
    it "is valid with a email and password" do
      expect(user).to be_valid
    end

    context "email" do
      it { should validate_presence_of(:email) }
      it { should validate_length_of(:email).is_at_most(255) }
      it { should validate_uniqueness_of(:email) }

      it "is invalid with a duplicate email" do
        second_user = User.new(email: user.email, password: "new_password")
        expect(second_user.valid?).to eq false
      end
    end

    context "password" do
      it "is invalid without a password" do
        user.password = nil
        expect(user.valid?).to eq false
      end

      it "is invalid with a shorter email than 6 characters" do
        user.password = "#{"a" * 5}"
        expect(user.valid?).to eq false
      end
    end
  end
end
