require 'rails_helper'

RSpec.feature 'User authentication' do
  before do
    @user = User.new(email: 'test@example.com', password: 'password')
    @user.skip_confirmation!
    @user.save
  end

  def give_valid_credentials
    fill_in 'user[email]', with: 'test@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
  end

  def give_invalid_credentials
    fill_in 'user[email]', with: ''
    fill_in 'user[password]', with: ''
    fill_in 'user[password_confirmation]', with: ''
  end

  scenario 'User forgets his password' do
    visit '/'
    click_link 'Forget your password?'
    expect(page).to have_button('Send me reset password instructions')
    fill_in 'user[email]', with: 'test@example.com'
    click_button 'Send me reset password instructions'
    expect(page).to have_content('You will receive an email with instructions on how to reset your password in a few minutes.')
  end

  context 'Sign up' do
    before do
      visit '/'
      click_link 'Sign up'
    end

    scenario 'with valid credentials' do
      @user.destroy

      give_valid_credentials
      click_button 'Sign up'

      expect(page).to have_content('A message with a confirmation link has been sent to your email address.')
      expect(page).to have_link('Sign up')
      expect(page).to have_link('Sign in')
    end

    scenario 'without giving credentials' do
      give_invalid_credentials

      click_button 'Sign up'

      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
      expect(page).not_to have_link('Sign out')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    scenario 'with used credentials' do
      give_invalid_credentials
      fill_in 'user[email]', with: @user.email

      click_button 'Sign up'

      expect(page).to have_content('Email has already been taken')
      expect(page).to have_content("Password can't be blank")
      expect(page).not_to have_link('Sign out')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end
  end

  context 'Sign in' do
    before do
      visit '/'
      click_link 'Sign in'
    end

    scenario 'with valid credentials' do
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      click_button 'Log in'

      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_link('Sign out')
    end

    scenario 'with invalid credentials' do
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      click_button 'Log in'

      expect(page).to have_content('Invalid Email or password.')
      expect(page).not_to have_link('Sign out')
    end
  end

  context 'Logged in user' do
    before do
      sign_in @user
      visit '/'
    end

    scenario 'User edits his profile' do
      expect(page).to have_link('Profile')
      click_link('Profile')
      expect(page).to have_content('Edit User')
      expect(page).to have_button('Update')
      expect(page).to have_field('email')
      fill_in 'user[first_name]', with: 'Johnny'
      fill_in 'user[last_name]', with: 'Walker'
      click_button 'Update'
      expect(page).to have_content('Your account has been updated successfully.')
    end

    scenario 'User signes out' do
      click_link 'Sign out'
      expect(page).to have_content('Signed out successfully.')
      expect(page).not_to have_link('Sign out')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end
  end
end
