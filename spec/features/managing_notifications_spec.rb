require 'rails_helper'

RSpec.feature 'Managing notifications' do
  context 'user doesnt need to accept follow' do
    before(:each) do
      @user = FactoryGirl.create :user
      login(@user)

      @follower = FactoryGirl.build :user
      @follow = FactoryGirl.build(:follow, followed: @user, follower: @follower)
      FactoryGirl.create :notification, follow: @follow
    end

    scenario 'list new notifications' do
      visit '/notifications'
      within 'h1' do
        expect(page).to have_content 'New Notifications'
      end
      expect(page).to have_content "Yay! #{@follower.name} is following you."
    end

    scenario 'notification wont be showed again once its seen' do
      visit '/notifications'
      visit '/'
      visit 'notifications'

      within 'h1' do
        expect(page).to have_content 'New Notifications'
      end
      expect(page).to have_content 'No notifications. Nobody likes you! :)'
    end
  end

  context 'user needs to accept follow' do
    before :each do
      @user = FactoryGirl.create :user, need_accept: true
      login(@user)

      @follower = FactoryGirl.build :user
      @follow = FactoryGirl.create(:follow, followed: @user, follower: @follower, accepted: false)
      FactoryGirl.create :notification, follow: @follow
    end

    scenario 'list new notifications' do
      visit '/notifications'
      within 'h1' do
        expect(page).to have_content 'New Notifications'
      end
      expect(page).to have_content "Yay! #{@follower.name} wants to follow you. Do you accept it?"
      expect(page).to have_selector(:link_or_button, 'Yes')
      expect(page).to have_selector(:link_or_button, 'No')
    end

    scenario 'notification will be showed as pending once its seen' do
      visit '/notifications'
      visit '/'
      visit 'notifications'

      expect(page).to have_content 'Pending Notifications'
      expect(page).to have_content "Yay! #{@follower.name} wants to follow you. Do you accept it?"
      expect(page).to have_selector(:link_or_button, 'Yes')
      expect(page).to have_selector(:link_or_button, 'No')
    end

    scenario 'user accepts follow' do
      visit '/notifications'

      click_button 'Yes'
      expect(page).to have_content 'Follower accepted!'
    end

    scenario 'user rejects follow' do
      visit '/notifications'

      click_button 'No'
      expect(page).to have_content 'Follower rejected!'
    end
  end
end