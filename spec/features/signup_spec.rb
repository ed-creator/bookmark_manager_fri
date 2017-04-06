feature 'allows user to sign up with an email & password' do
  scenario 'user sign up' do
    visit '/users/new'
    fill_in 'email', with: 'bob@gmail.com'
    fill_in 'password', with: 's3cr3t'
    click_button 'Sign Up'
    expect(current_path).to eq '/links'
    expect(page).to have_content 'Welcome, bob@gmail.com'
    expect(User.count).to eq 1
    end
end
