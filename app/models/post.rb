class Post < ActiveRecord::Base

  include Voteable
  include Sluggable

  before_create do 
    add_slug(title)
  end

  belongs_to :creator, foreign_key: "user_id", class_name: "User"
  has_many :comments, dependent: :destroy
  has_many :post_categories
  has_many :categories, through: :post_categories
  
  validates :title, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true
  
end