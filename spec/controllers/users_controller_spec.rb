require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryGirl.create :user }

  before(:each) do
    login(user)
  end

  describe 'GET show' do
    it "assigns tweets from requested user to @tweets" do
      tweet = FactoryGirl.create :tweet, user: user

      get :show, id: user
      tweets = assigns(:tweets)

      expect(tweets).to match_array [tweet]
    end

    it "renders the #show view" do
      get :show, id: user

      expect(controller).to respond_with :ok
      expect(response).to render_template :show
    end
  end
end
