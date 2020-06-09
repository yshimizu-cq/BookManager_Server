require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "validation" do
    let(:book) { create(:book) }

    it "is valid with a name" do
      expect(book).to be_valid
    end

    it "is invalid without a name" do
      book.name = nil
      book.valid?
      expect(book.errors[:name]).to include("can't be blank")
    end
  end
end
