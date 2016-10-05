require 'rails_helper'

RSpec.describe Tweet, type: :model do
  let(:user) { FactoryGirl.create :user }
  subject { FactoryGirl.create(:tweet, user: user) }

  describe 'validations' do
    # it { is_expected.to validate_presence_of(:user) }

    it 'is valid with a valid text' do
      is_expected.to validate_presence_of(:text)
      is_expected.to validate_length_of(:text).is_at_most(140)
    end

    # it 'is not valid without a text' do
    #   subject.text = nil
    #   is_expected.to_not be_valid
    # end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end