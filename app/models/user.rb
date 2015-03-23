class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  
  has_secure_password
  
  validates :username, uniqueness: true, presence: true
  validates :password, length: {minimum: 3}, presence: true, on: :create
  validates :email, presence: true
end