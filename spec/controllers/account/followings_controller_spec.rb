require 'rails_helper'

RSpec.describe Account::FollowingsController, type: :controller do

  let(:user) { FactoryGirl.create :user }

  before(:each) do
    login(user)
  end

  describe 'GET show' do
    it "assigns followings from current user to @following" do
      follow = FactoryGirl.create :follow, follower: user

      get :show, user_id: user
      followings = assigns(:following)

      expect(followings).to match_array [follow.followed]
    end

    it "renders the #followers view" do
      get :show, user_id: user

      expect(controller).to respond_with :ok
      expect(response).to render_template :show
    end
  end
end