class Category < ActiveRecord::Base

  include Sluggable

  has_many :post_categories
  has_many :posts, through: :post_categories
  
  validates :name, presence: true, uniqueness: true
  
  before_create do
    add_slug(name)
  end
  

end
