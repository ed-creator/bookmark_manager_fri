require 'bcrypt'
require 'securerandom'

class User

  include DataMapper::Resource

  property :id, Serial
  property :email, String, :required => true, :format => :email_address, unique: true
  property :password_digest, Text
  property :password_token, Text
  property :password_token_time, Time

  attr_accessor :password_confirmation
  attr_reader :password

  validates_confirmation_of :password


  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

  def generate
    self.password_token = SecureRandom.hex
    self.password_token_time = Time.now
    self.save
  end

  def password_recovery?(email, input_token)
    Time.now <= password_token_time + (60 * 60) && input_token == password_token
  end



end
