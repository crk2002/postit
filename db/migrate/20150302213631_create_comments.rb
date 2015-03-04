class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
        t.text :body
        t.integer :post_id
        t.integer :user_id
    end
  end
end
