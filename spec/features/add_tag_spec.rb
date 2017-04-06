feature 'adding tags' do
  before(:each) do
    User.create(email: 'bob@gmail.com', password: 's3cr3t')
  end
  scenario 'add tag to site' do
    visit '/links/new'
    fill_in 'url', with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tag_name', with: 'Bootcamp'
    click_button 'Save link'
    link = Link.first
    expect(link.tags.map(&:tag_name)).to include 'Bootcamp'
  end

  scenario 'can add multiple tags to the site' do
    visit '/links/new'
    fill_in 'url', with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tag_name', with: 'Bootcamp, Web, Makers'
    click_button 'Save link'
    link = Link.first
    expect(link.tags.map(&:tag_name)).to include 'Bootcamp'
    expect(link.tags.map(&:tag_name)).to include 'Web'
    expect(link.tags.map(&:tag_name)).to include 'Makers'
  end
end
