require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:follow) { Follow.new }
  subject { Notification.new(follow: follow) }

  describe 'delegates' do
    it { is_expected.to delegate_method(:follower_name).to(:follow) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:follow) }
  end

  describe 'methods' do
    describe '#mark_as_seen_for' do
      it 'sets all unseen notifications from a user as seen' do
        followed = (FactoryGirl.create :user)
        follow = FactoryGirl.create :follow, follower: (FactoryGirl.build :user), followed: followed
        FactoryGirl.create :notification, follow: follow

        expect(Notification.mark_as_seen_for(followed)).to eq(1)
      end
    end
  end

  describe 'scopes' do #scope sempre olha o banco
    describe '#unseen' do
      it 'returns only notifications where seen is false' do
        Notification.create(follow: follow, seen: true)
        unseen_notification = FactoryGirl.create :notification
        expect(Notification.unseen).to match_array([unseen_notification])
      end
    end

    describe '#seen' do
      it 'returns only notifications where seen is true' do
        Notification.create(follow: follow)
        seen_notification = FactoryGirl.create :notification, seen: true
        expect(Notification.seen).to match_array([seen_notification])
      end
    end
    describe '#unaccepted' do
      it 'returns only notifications from follows that were not accepted yet' do
        unaccepted_follow = FactoryGirl.create :follow
        unaccepted_follow.accepted = false
        unaccepted_follow.save
        unaccepted_notification = Notification.create(follow: unaccepted_follow)
        expect(Notification.unaccepted).to match_array([unaccepted_notification])
      end
    end
  end
end
