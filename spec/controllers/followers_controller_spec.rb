require 'rails_helper'

RSpec.describe FollowersController, type: :controller do

  let(:user) { FactoryGirl.create :user }

  before(:each) do
    login(user)
  end

  describe 'GET show' do
    it "assigns followers from requested user to @followers" do
      follow = FactoryGirl.create :follow, followed: user

      get :show, user_id: user
      followers = assigns(:followers)

      expect(followers).to match_array [follow.follower]
    end

    it "renders the #followers view" do
      get :show, user_id: user

      expect(controller).to respond_with :ok
      expect(response).to render_template :show
    end
  end
end