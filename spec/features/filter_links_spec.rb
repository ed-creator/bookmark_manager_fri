feature 'Filter by links' do

  before(:each) do
    Link.create(url: 'www.makersacademy.com', title: 'Makers Academy', tags: [Tag.first_or_create(tag_name: 'education')])
    Link.create(url: 'www.google.com', title: 'Google', tags: [Tag.first_or_create(tag_name: 'search')])
    Link.create(url: 'www.zombo.com', title: 'This is Zombocom', tags: [Tag.first_or_create(tag_name: 'bubbles')])
    Link.create(url: 'www.bubble-bobble.com', title: 'Bubble Bobble', tags: [Tag.first_or_create(tag_name: 'bubbles')])
  end

  scenario "returns links tagged to 'bubbles'" do
    visit '/links'
    fill_in 'filter', with: 'bubbles'
    click_button 'Search'

    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).to have_content "This is Zombocom"
      expect(page).to have_content "Bubble Bobble"
      expect(page).not_to have_content "Makers Academy"
      expect(page).not_to have_content "Google"
    end
  end

  scenario 'returns the title with search term' do
    visit '/links'
    fill_in 'filter', with: 'bubbles'
    click_button 'Search'
    expect(page).to have_content "Links containing the tag: 'bubbles'"
  end

end
