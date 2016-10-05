require 'rails_helper'

RSpec.describe Account::FollowersController, type: :controller do

  let(:user) { FactoryGirl.create :user }

  before(:each) do
    login(user)
  end

  describe 'GET index' do
    it "assigns follows from current user to @follows" do
      follow = FactoryGirl.create :follow, followed: user

      get :index
      follows = assigns(:follows)

      expect(follows).to match_array [follow]
    end

    it "renders the #followers view" do
      get :index

      expect(controller).to respond_with :ok
      expect(response).to render_template :index
    end
  end

  describe 'PUT update' do
    context "with valid follow" do
      before(:each) do
        @follow = FactoryGirl.create :follow, followed: user, accepted: false
      end

      it "accepts follow" do
        put :update, id: @follow, follow: FactoryGirl.attributes_for(:follow, accepted: true)
        @follow.reload

        expect(@follow.accepted).to eq true
      end

      it "redirects to notifications path" do
        put :update, id: @follow, follow: FactoryGirl.attributes_for(:follow, accepted: true)

        expect(controller).to respond_with :redirect
        expect(response).to redirect_to(notifications_path)
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @follow = FactoryGirl.create :follow, followed: user
    end

    it "deletes the follow" do
      expect{
        delete :destroy, id: @follow
      }.to change(Follow,:count).by(-1)
    end

    it "redirects to unfollowed user path" do
      delete :destroy, id: @follow

      expect(controller).to respond_with :redirect
      expect(response).to redirect_to(notifications_path)
    end
  end
end