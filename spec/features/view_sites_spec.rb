
feature 'viewing saved sites' do
  before(:each) do
    User.create(email: 'bob@gmail.com', password: 's3cr3t')
  end
  scenario 'seeing existing links on the links page' do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit '/links'
    expect(page.status_code).to eq 200
    within "ul#links" do
      expect(page).to have_content("Makers Academy")
    end
  end
end
