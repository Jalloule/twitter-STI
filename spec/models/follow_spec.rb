require 'rails_helper'

RSpec.describe Follow, type: :model do
  let(:follow) { Follow.new }
  subject { follow }

  describe 'delegates' do
    it { is_expected.to delegate_method(:name).to(:follower).with_prefix(true) }
  end

  describe 'before validation' do
    describe '#needs_to_accept?' do
      # accepted = true unless followed
      # accepted = false if followed.need_accept => true
      # accepted = true if followed.need_accept => false
      it 'is true if followed not present' do
        follow.followed = nil
        expect(follow.accepted).to be true
      end
      it 'is false if followed doesnt need to accept' do
        follow.followed = User.new(need_accept: true)
        follow.save
        expect(follow.accepted).to be false
      end
      it 'is true if followed needs to accept' do
        follow.followed = User.new(need_accept: false)
        follow.save
        expect(follow.accepted).to be true
      end
      # it 'is true if followed needs to accept' do
      #   user = mock_model('User') #User.new
      #   allow(user).to_receive(:need_accept?).and_return false
      #   follow.followed = user
      #   follow.save
      #   expect(follow.accepted).to be true
      # end
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:follower) }
    it { is_expected.to validate_presence_of(:followed) }
    it { is_expected.to validate_uniqueness_of(:follower_id).scoped_to(:followed_id) }

    describe 'followed_id' do
      it 'is valid if its different than follower_id' do
        follow.follower_id = 999
        follow.followed_id = 123

        follow.valid?

        expect(follow.errors[:followed_id]).to_not include('You cannot follow yourself!')
      end
      it 'is invalid if its the same as follower_id' do
        follow.follower_id = 999
        follow.followed_id = 999

        follow.valid?

        expect(follow.errors[:followed_id]).to include('You cannot follow yourself!')
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:follower).class_name('User') }
    it { is_expected.to belong_to(:followed).class_name('User') }
    it { is_expected.to have_many(:notifications).dependent(:destroy) }
  end

  describe 'scopes' do
    describe '#not_accepted' do
      it 'returns only follows where accepted is false' do
        FactoryGirl.create :follow, accepted: true
        unaccepted_follow = FactoryGirl.build :follow
        unaccepted_follow.accepted = false
        unaccepted_follow.save(validate: false)
        # unaccepted_follow.update_attribute('accepted', false)

        expect(Follow.not_accepted).to match_array([unaccepted_follow])
      end
    end
  end
end