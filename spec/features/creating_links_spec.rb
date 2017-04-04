require 'capybara/rspec'

feature 'can save websites' do
  scenario 'can submit new link to bookmark manager' do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit '/links/new'
    fill_in 'url', with: 'http://www.zombo.com/'
    fill_in 'title', with: 'This is Zombocom'
    click_button 'Save link'
    expect(current_path).to eq '/links'
    within 'ul#links' do
      expect(page).to have_content 'Makers Academy'
    end
  end
end
