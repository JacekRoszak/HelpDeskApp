require 'rails_helper'

RSpec.feature 'User authentication' do
  before do
    @user = User.create!(email: 'test@example.com', password: 'password')
  end

  context 'Sign up ' do
    scenario 'with valid credentials' do
      @user.destroy
      visit '/'

      click_link 'Sign up'

      fill_in 'user[email]', with: 'test@example.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'

      click_button 'Sign up'

      expect(page).to have_content('Welcome! You have signed up successfully.')
      expect(page).to have_link('Sign out')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

    scenario 'without giving credentials' do
      visit '/' 

      click_link 'Sign up'

      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      fill_in 'user[password_confirmation]', with: ''

      click_button 'Sign up'

      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
      expect(page).not_to have_link('Sign out')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    scenario 'with used credentials' do
      visit '/'

      click_link 'Sign up'

      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: ''
      fill_in 'user[password_confirmation]', with: ''

      click_button 'Sign up'

      expect(page).to have_content('Email has already been taken')
      expect(page).to have_content("Password can't be blank")
      expect(page).not_to have_link('Sign out')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end
  end

  context 'Sign in' do
    scenario 'with valid credentials' do
      visit '/'

      click_link 'Sign in'
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      click_button 'Log in'

      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_link('Sign out')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

    scenario 'with invalid credentials' do
      visit '/'

      click_link 'Sign in'
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      click_button 'Log in'

      expect(page).to have_content('Invalid Email or password.')
      expect(page).not_to have_link('Sign out')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end
  end

  context 'Sign out User' do
    before do
      visit '/'

      click_link 'Sign in'
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      click_button 'Log in'
    end

    scenario 'with valid credentials' do
      visit '/'

      click_link 'Sign out'
      expect(page).to have_content('Signed out successfully.')
      expect(page).not_to have_link('Sign out')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end
  end
end
