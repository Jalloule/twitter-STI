require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  let(:user) { FactoryGirl.create :user }

  before(:each) do
    login(user)
  end

  describe 'GET new' do
    it 'successfully responds' do
      get :new

      expect(controller).to respond_with :ok
      expect(response).to render_template :new
      # expect(response).to render_with_layout :application
    end

    it 'sets up a new tweet' do
      get :new

      new_tweet = assigns(:tweet)

      expect(new_tweet).to be_a_new Tweet
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new tweet" do
        expect{
          post :create, {tweet: FactoryGirl.attributes_for(:tweet)}
        }.to change(Tweet,:count).by(1)
      end

      it "redirects to root path" do
        post :create, {tweet: FactoryGirl.attributes_for(:tweet)}

        expect(controller).to respond_with :redirect
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid attributes" do
      it "does not save the new tweet" do
        expect{
          post :create, tweet: FactoryGirl.attributes_for(:tweet, :invalid_tweet)
        }.to_not change(Tweet,:count)
      end

      it "re-renders the new method" do
        post :create, tweet: FactoryGirl.attributes_for(:tweet, :invalid_tweet)
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @tweet = FactoryGirl.create(:tweet, user: user)
    end

    it "deletes the contact" do
      expect{
        delete :destroy, id: @tweet
      }.to change(Tweet,:count).by(-1)
    end

    it "redirects to contacts#index" do
      delete :destroy, id: @tweet

      expect(controller).to respond_with :redirect
      expect(response).to redirect_to(user_path(user))
    end
  end
end