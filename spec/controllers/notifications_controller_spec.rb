require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  let(:user) { FactoryGirl.create :user }

  before(:each) do
    login(user)
  end

  describe "GET #index" do
    it "populates an array of notifications containing new notifications" do
      new_follow = FactoryGirl.create :follow, followed: user
      notification = FactoryGirl.create :notification, follow: new_follow

      get :index
      notifications = assigns(:new_notifications)

      expect(notifications).to match_array [notification]
    end

    it "populates an array of notifications containing pending notifications" do
      user.update_attribute('need_accept', true)
      pending_follow = FactoryGirl.create :follow, followed: user, accepted: false
      notification = FactoryGirl.create :notification, follow: pending_follow, seen: true

      get :index
      notifications = assigns(:pending_notifications)

      expect(notifications).to match_array [notification]
    end

    it "turns unseen notifications seen" do
      new_follow = FactoryGirl.create :follow, followed: user
      notification = FactoryGirl.create :notification, follow: new_follow

      get :index

      expect(notification.reload.seen).to be true
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end
end
