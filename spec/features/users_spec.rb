require 'rails_helper'
RSpec.feature 'User login', type: :feature do
    let(:user) { FactoryBot.create(:user) }
  
    scenario 'User logs in and log out' do
      # Visit login page
      visit new_user_session_path
  
      # Fill in login form
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
  
      expect(page).to have_current_path(root_path)
  
      click_button 'Log out'
    end
  end
  RSpec.feature 'Visit home user page', type: :feature do
    let(:user) { FactoryBot.create(:user) }
  
    scenario 'User logs in successfully' do
      # Visit login page
      visit new_user_session_path
  
      # Fill in login form
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
  
      # Expect to be redirected to posts_index
      expect(page).to have_current_path(root_path)
  
      # Expect to see user's feed
      expect(page).to have_content("Feed")
      click_link 'My page'
      expect(page).to have_current_path(user_path(user.id))
    end
  end
  RSpec.feature 'User login & log out', type: :feature do
    let(:user) { FactoryBot.create(:user) }
  
    scenario 'User logs in and log out' do
      # Visit login page
      visit new_user_session_path
  
      # Fill in login form
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
  
      expect(page).to have_current_path(root_path)
  
      click_button 'Log out'
    end
  end
  RSpec.feature 'User search and follow other user', type: :feature do
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post) }
    scenario 'User search & follow' do

      visit new_user_session_path
  
      fill_in 'Email', with: user1.email
      fill_in 'Password', with: user1.password
      click_button 'Log in'

      fill_in 'search', with: user2.name
      click_button 'Search'
      expect(page).to have_content("#{user2.name}")
      click_link ("#{user2.name}")
      expect(page).to have_selector(:link_or_button, 'Follow')
      click_button 'Follow'
      expect(page).to have_selector(:link_or_button, 'Unfollow')
    end
    scenario 'User go to followers page & unfollow' do

      visit new_user_session_path
  
      fill_in 'Email', with: user1.email
      fill_in 'Password', with: user1.password
      click_button 'Log in'

      fill_in 'search', with: user2.name
      click_button 'Search'
      expect(page).to have_content("#{user2.name}")
      click_link ("#{user2.name}")
      expect(page).to have_selector(:link_or_button, 'Follow')
      click_button 'Follow'

      visit "/subscribes/#{user1.id}"
      expect(page).to have_content("#{user2.name}")
      click_link ("#{user2.name}")
      expect(page).to have_selector(:link_or_button, 'Unfollow')
      click_button "Unfollow"
      expect(page).to have_content("Subscribes: 0")

    end

    scenario 'User search & null result' do

      visit new_user_session_path
  
      fill_in 'Email', with: user1.email
      fill_in 'Password', with: user1.password
      click_button 'Log in'

      fill_in 'search', with: 'find somebody'
      click_button 'Search'
      #expect(page).to have_content("#{user2.name}")
    end
  end

 RSpec.feature 'User login', type: :feature do
    let(:user) { FactoryBot.create(:user) }
  
    scenario 'User logs in and log out' do
      # Visit login page
      visit new_user_session_path
  
      # Fill in login form
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
  
      expect(page).to have_current_path(root_path)
  
      click_button 'Log out'
    end
  end
  RSpec.feature 'Delete account', type: :feature do
    let(:user1) { FactoryBot.create(:user) }

    scenario 'User deletes account' do
      # Visit login page
      visit new_user_session_path
  
      # Fill in login form
      fill_in 'Email', with: user1.email
      fill_in 'Password', with: user1.password
      click_button 'Log in'
  
      expect(page).to have_current_path(root_path)
  
      click_link 'Settings'
      expect(page).to have_selector(:link_or_button, 'Cancel my account')
      click_button 'Cancel my account'
      expect(page).to have_current_path(new_user_session_path)
    end
  end