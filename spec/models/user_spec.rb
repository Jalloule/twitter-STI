require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create :user  }
  subject { user }

  describe 'validations' do
    it { is_expected.to validate_length_of(:description).is_at_most(140) }
    it { is_expected.to validate_presence_of(:email) }

    # it 'is not valid without an email' do
    #   subject.email = nil
    #   is_expected.to_not be_valid
    # end
  end

  describe 'associations' do
    it { is_expected.to have_many(:tweets).dependent(:destroy) }
    it { is_expected.to have_many(:followings).class_name('Follow').with_foreign_key(:follower_id) }
    it { is_expected.to have_many(:followers).class_name('Follow').with_foreign_key(:followed_id) }
    it { is_expected.to have_many(:follower_users).through(:followers).source(:follower) }
    it { is_expected.to have_many(:following_users).through(:followings).source(:followed) }
    it { is_expected.to have_many(:notifications).class_name('Notification').through(:followers) }
  end

  describe '#follows?' do
    it 'returns true if subject is following passed user' do
      other_user = FactoryGirl.create :user
      user.followings.create(followed_id: other_user.id)

      expect(user.follows?(other_user)).to be true
    end
    it 'returns false if subject isnt following passed user' do
      other_user = FactoryGirl.create :user

      expect(user.follows?(other_user)).to be false
    end
  end
end