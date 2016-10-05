require 'rails_helper'

RSpec.describe Timeline, type: :model do
  describe 'methods' do
    describe '#tweets' do
      it 'returns tweets from people being followed by user' do
        followed = FactoryGirl.build :user
        user = FactoryGirl.create :user
        FactoryGirl.create :follow, follower: user, followed: followed
        tweet = FactoryGirl.create :tweet, user: followed

        expect(Timeline.new(user, 1).tweets).to match_array(tweet)
      end
    end
  end
end
