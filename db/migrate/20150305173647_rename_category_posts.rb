class RenameCategoryPosts < ActiveRecord::Migration
  def self.up
    rename_table :category_posts, :post_categories
  end

 def self.down
    rename_table :post_categories, :category_posts
 end

end
