feature 'adding tags' do
  scenario 'add tag to site' do
    visit '/links/new'
    fill_in 'url', with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tag_name', with: 'Bootcamp'
    click_button 'Save link'
    expect(current_path).to eq '/links'
    within "ul#links" do
      expect(page).to have_content("Bootcamp")
    end
  end
end
