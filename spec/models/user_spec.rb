require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password_digest }
  end

  describe 'instance methods' do
    it 'gererate_api_key' do
      user = User.new.generate_api_key

      expect(user).to be_a(String)
      expect(user.length).to eq(26)
    end
  end
end