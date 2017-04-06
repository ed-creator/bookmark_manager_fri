require 'capybara/rspec'

feature 'can save websites' do
  before(:each) do
    User.create(email: 'bob@gmail.com', password: 's3cr3t')
  end
  scenario 'can submit new link to bookmark manager' do
    visit '/links/new'
    fill_in 'url', with: 'http://www.zombo.com/'
    fill_in 'title', with: 'This is Zombocom'
    click_button 'Save link'
    expect(current_path).to eq '/links'
    within 'ul#links' do
      expect(page).to have_content 'This is Zombocom'
    end
  end
end
