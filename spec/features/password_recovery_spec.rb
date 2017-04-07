feature 'password recovery' do
  before(:each) do
    User.create(email: 'bob@gmail.com', password: 's3cr3t', password_confirmation: 's3cr3t')
  end

  scenario 'user asks for password recovery' do
    visit'/sessions/new'
    click_button 'Forgot Password?'
    expect(current_path).to eq '/sessions/forgot_password'
  end

  scenario 'user forgets password' do
    visit'/sessions/forgot_password'
    fill_in :email, with: 'bob@gmail.com'
    click_button 'Submit'
    expect(page).to have_content 'Recovery email sent'
  end

  scenario 'user given token' do
    expect{recover_password}.to change{User.first.password_token}
  end

  def recover_password
    visit'/sessions/forgot_password'
    fill_in :email, with: 'bob@gmail.com'
    click_button 'Submit'
  end
end
