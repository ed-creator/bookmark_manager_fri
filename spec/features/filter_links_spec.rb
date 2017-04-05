feature 'Filter by links' do
  scenario "returns links tagged to 'bubbles'" do
    visit '/links/new'
    fill_in 'url', with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tag_name', with: 'Bootcamp'
    click_button 'Save link'
    click_button 'Save new link'
    fill_in 'url', with: 'http://www.bubbles.com/'
    fill_in 'title', with: 'Bath foam party'
    fill_in 'tag_name', with: 'bubbles'
    click_button 'Save link'
    fill_in 'filter', with: 'bubbles'
    click_button 'Search'
    within 'ul#links' do
      expect(page).to have_content "Bath foam party"
      expect(page).not_to have_content "Makers Academy"
    end
  end

  scenario 'returns the title with search term' do
    visit '/links/new'
    fill_in 'url', with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tag_name', with: 'Bootcamp'
    click_button 'Save link'
    click_button 'Save new link'
    fill_in 'url', with: 'http://www.bubbles.com/'
    fill_in 'title', with: 'Bath foam party'
    fill_in 'tag_name', with: 'bubbles'
    click_button 'Save link'
    fill_in 'filter', with: 'bubbles'
    click_button 'Search'
    expect(page).to have_content "Links containing the tag: 'bubbles'"
  end

end
