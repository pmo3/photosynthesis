require 'spec_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:password_digest) }

    it 'has a valid factory' do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end
end
