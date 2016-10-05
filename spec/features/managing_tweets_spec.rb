require 'rails_helper'

RSpec.feature 'Managing tweets' do
  given(:user) { FactoryGirl.create :user }

  background do
    login(user)
  end

  scenario 'creating a new tweet' do
    visit '/'
    expect{
      click_link 'Publish New Tweet'
      fill_in 'tweet[text]', with: 'Oi! Isso é um tweet.'
      click_button "Tweet"
    }.to change(Tweet, :count).by(1)
    expect(page).to have_content "Tweet was successfully published!"
  end
end