require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validation" do
    before do
      @user = create(:user)
    end

    it "is valid with a email and password" do
      expect(@user).to be_valid
    end

    context "email" do
      it "is invalid without a email" do
        @user.email = nil
        @user.valid?
        expect(@user.errors[:email]).to include("can't be blank")
      end

      it "is invalid with a longer email than 255 characters" do
        @user.email = "#{"a" * 256}@email.com"
        @user.valid?
        expect(@user.errors[:email]).to include("is too long (maximum is 255 characters)")
      end

      it "is invalid with a duplicate email" do
        second_user = User.new(email: @user.email, password: @user.password)
        second_user.valid?
        expect(second_user.errors[:email]).to include("has already been taken")
      end
    end

    context "password" do
      it "is invalid without a password" do
        @user.password = nil
        @user.valid?
        expect(@user.errors[:password]).to include("can't be blank")
      end

      it "is invalid with a shorter email than 6 characters" do
        @user.password = "#{"a" * 5}"
        @user.valid?
        expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
      end
    end
  end
end
