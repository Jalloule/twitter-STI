require 'rails_helper'

RSpec.describe FollowsController, type: :controller do

  let(:user) { FactoryGirl.create :user }
  let(:followed) { FactoryGirl.create :user }

  before(:each) do
    login(user)
  end

  describe 'POST create' do
    context "with valid follower and followed" do
      it "creates a new follow" do
        expect{
          post :create, { follow: FactoryGirl.attributes_for(:follow), user_id: followed }
        }.to change(Follow,:count).by(1)
      end

      it "redirects to followed user path" do
        post :create, { follow: FactoryGirl.attributes_for(:follow), user_id: followed }

        expect(controller).to respond_with :redirect
        expect(response).to redirect_to(user_path(followed))
      end
    end

    context "with follower being the same user as followed" do
      it "does not save the new follow" do
        expect{
          post :create, { follow: FactoryGirl.attributes_for(:follow), user_id: user.id }
        }.to_not change(Follow,:count)
      end

      it "redirects to followed user path" do
        post :create, { follow: FactoryGirl.attributes_for(:follow), user_id: user.id }

        expect(controller).to respond_with :redirect
        expect(response).to redirect_to(user_path(user))
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @follow = FactoryGirl.create(:follow, followed: followed, follower: user)
    end

    it "deletes the follow" do
      expect{
        delete :destroy, user_id: followed
      }.to change(Follow,:count).by(-1)
    end

    it "redirects to unfollowed user path" do
      delete :destroy, user_id: followed

      expect(controller).to respond_with :redirect
      expect(response).to redirect_to(user_path(followed))
    end
  end
end
