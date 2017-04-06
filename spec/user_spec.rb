describe User do

  let!(:user) do
    User.create(email: 'bob@gmail.com',password: 's3cr3t', password_confirmation: 's3cr3t')
  end

  describe '#authenticate' do
    it 'should authenticate a user' do
      authenticated_user = User.authenticate(user.email, user.password)
      expect(authenticated_user).to eq user
    end

    it 'user fails authentication' do
      expect(User.authenticate(user.email, 'secret')).to be_nil
    end
  end
end
