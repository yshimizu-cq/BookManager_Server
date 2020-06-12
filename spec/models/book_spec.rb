require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "relation" do
    it { should belong_to(:user) }
  end
  
  describe "validation" do
    it { should validate_presence_of(:name) }
  end
end
