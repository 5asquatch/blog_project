require 'rails_helper'

RSpec.feature 'Visit homepage without login', type: :feature do
  scenario 'Visit index page' do
    visit posts_path
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end
end
RSpec.feature 'User login', type: :feature do
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
    end
  end
  RSpec.feature 'User register', type: :feature do
    let(:avatar_file_path) { (Rails.root.join("app/assets/images/default-avatar.png"))}
    scenario 'User visit register page' do

      # Visit register page
      visit new_user_session_path
      click_link 'Sign up'
      expect(page).to have_current_path(new_user_registration_path)
      # Fill in register form
      attach_file (avatar_file_path)
      fill_in 'Email', with: "user2@mail.ru"
      fill_in 'Name', with: "user2"
      fill_in 'Password', with: "123123"
      fill_in 'Password confirmation', with: "123123"
      click_button 'Sign up'
      
      # Expect to see Feed
      expect(page).to have_content("Feed")
    end
  end
  RSpec.feature 'User creates post', type: :feature do
    let(:user) { FactoryBot.create(:user) }
    let(:post) {FactoryBot.create(:post)}
    let(:image_file_path) { (Rails.root.join("app/assets/images/default-avatar.png"))}
    scenario 'User logs in and create post' do
      visit new_user_session_path
  
      # Fill in login form
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'

      expect(page).to have_current_path(root_path)
      click_link 'Create Post'
      expect(page).to have_current_path(new_post_path)
      attach_file (image_file_path)
      fill_in 'Title', with: post.title
      fill_in 'Body', with: post.body
      click_button 'Save Post'
      expect(page).to have_content("#{post.body}")
    
    end
  end
  RSpec.feature 'User actioins with his own post', type: :feature do
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post) }
    let(:image_file_path) { (Rails.root.join("app/assets/images/default-avatar.png"))}
    let(:comment) {FactoryBot.create(:comment)}
    scenario 'User likes his own post' do

      visit new_user_session_path
  
      fill_in 'Email', with: user1.email
      fill_in 'Password', with: user1.password
      click_button 'Log in'

      click_link 'Create Post'
      expect(page).to have_current_path(new_post_path)
      attach_file (image_file_path)
      fill_in 'Title', with: post.title
      fill_in 'Body', with: post.body
      click_button 'Save Post'
      expect(page).to have_selector(:link_or_button, 'Like')
      click_button 'Like'
      expect(page).to have_content '1 Like'
      expect(page).to have_selector(:link_or_button, 'Unlike')
    end
    scenario 'User comments his own post' do

      visit new_user_session_path
  
      fill_in 'Email', with: user1.email
      fill_in 'Password', with: user1.password
      click_button 'Log in'

      click_link 'Create Post'
      expect(page).to have_current_path(new_post_path)
      attach_file (image_file_path)
      fill_in 'Title', with: post.title
      fill_in 'Body', with: post.body
      click_button 'Save Post'

      fill_in 'comment_body', with: comment.body
      click_button 'Create Comment'
      expect(page).to have_content "#{comment.body}"

    end

    scenario 'User deletes his own post' do

      visit new_user_session_path
  
      fill_in 'Email', with: user1.email
      fill_in 'Password', with: user1.password
      click_button 'Log in'

      click_link 'Create Post'
      expect(page).to have_current_path(new_post_path)
      attach_file (image_file_path)
      fill_in 'Title', with: post.title
      fill_in 'Body', with: post.body
      click_button 'Save Post'
      click_link 'My page'
      expect(page).to have_current_path(user_path(user1.id))
      expect(page).to have_selector(:link_or_button, 'Delete')
      click_link 'Delete'
      expect(page).to have_current_path(root_path)
    end
    
    scenario 'User edit his own post' do

      visit new_user_session_path
  
      fill_in 'Email', with: user1.email
      fill_in 'Password', with: user1.password
      click_button 'Log in'

      click_link 'Create Post'
      expect(page).to have_current_path(new_post_path)
      attach_file (image_file_path)
      fill_in 'Title', with: post.title
      fill_in 'Body', with: post.body
      click_button 'Save Post'
      click_link 'My page'
      expect(page).to have_current_path(user_path(user1.id))
      expect(page).to have_selector(:link_or_button, 'Edit')
      click_link 'Edit'
      expect(page).to have_content 'Edit post'
      fill_in 'Title', with: 'Edited Title'
      fill_in 'Body', with: 'Edited Body'
      click_button 'Update Post'
      expect(page).to have_content ("Edited Title")

    end


  end
