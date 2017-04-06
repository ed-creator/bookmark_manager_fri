feature 'allows user to sign up with an email & password' do
  scenario 'user sign up' do
    visit '/users/new'
    fill_in 'email', with: 'bob@gmail.com'
    fill_in 'password', with: 's3cr3t'
    fill_in 'password_confirmation', with: 's3cr3t'
    click_button 'Sign Up'
    expect(current_path).to eq '/links'
    expect(page).to have_content 'Welcome, bob@gmail.com'
    expect(User.count).to eq 1
    end

  scenario 'user wrong password confirmation' do
    visit '/users/new'
    fill_in 'email', with: 'bob@gmail.com'
    fill_in 'password', with: 's3cr3t'
    fill_in 'password_confirmation', with: 'secret'
    click_button 'Sign Up'
    expect(current_path).to eq '/users'
    expect(page).to have_content 'Passwords do not match!'
    expect(User.count).to eq 0
  end

  scenario 'do not enter email' do
    visit '/users/new'
    fill_in 'password', with: 's3cr3t'
    fill_in 'password_confirmation', with: 's3cr3t'
    expect(current_path).to eq '/users/new'
    click_button 'Sign Up'
    expect(User.count).to eq 0
  end

  scenario 'enter invalid email' do
    visit '/users/new'
    fill_in 'email', with: 'hi'
    fill_in 'password', with: 's3cr3t'
    fill_in 'password_confirmation', with: 's3cr3t'
    expect(current_path).to eq '/users/new'
    click_button 'Sign Up'
    expect(User.count).to eq 0
  end
end
