class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  
  include Sluggable

  before_validation :clean_phone

  before_create do 
    add_slug(username)
  end
  
  has_secure_password
  
  validates :username, uniqueness: true, presence: true
  validates :password, length: {minimum: 3}, presence: true, on: :create
  validates :email, presence: true
  validates :phone, length: {is: 10}
  
  def admin?
    admin
  end
  
  def phone_verified?
    phone_verified
  end
  
  def clean_phone
    phone.gsub!(/[\s()-]/,'')
  end
  
  def send_two_auth_code
    self.update two_auth_code: rand(100000 .. 999999)
    account_sid = Figaro.env.twilio_sid
    auth_token = Figaro.env.twilio_auth
    @client = Twilio::REST::Client.new account_sid, auth_token
     
    message = @client.account.messages.create(:body => "Your Rails code is: #{two_auth_code}",
        :to => "+1#{phone}",    
        :from => "+19175806770")
    puts message.sid
  end
  
end