require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { FactoryGirl.create :user }

  before(:each) do
    login(user)
  end

  describe "GET #index" do
    it "populates an array of tweets from people the user is following" do
      followed = FactoryGirl.create :user
      FactoryGirl.create :follow, followed: followed, follower: user
      tweet = FactoryGirl.create :tweet, user: followed

      get :index
      tweets = assigns(:tweets)

      expect(tweets).to match_array [tweet]
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end
end