require 'rails_helper'

RSpec.describe UserFollower, type: :model do
  let(:user) { FactoryGirl.create :user }
  let(:followed) { FactoryGirl.create :user }
  subject { UserFollower.new(user, followed) }

  describe 'methods' do
    describe '#follow_user' do
      it 'builds follow, creates notification for follow and saves follow' do
        follow = FactoryGirl.build :follow, follower: user, followed: followed
        notification = FactoryGirl.create :notification, follow: follow

        subject.follow_user

        expect(Notification.all).to include(notification)
        expect(Follow.all).to include(follow)
      end
    end
  end
end