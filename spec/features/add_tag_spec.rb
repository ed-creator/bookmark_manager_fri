feature 'adding tags' do
  scenario 'add tag to site' do
    visit '/links/new'
    fill_in 'url', with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tag_name', with: 'Bootcamp'
    click_button 'Save link'
    link = Link.first
    expect(link.tags.map(&:tag_name)).to include 'Bootcamp'
  end
end
