class AddTwoAuthCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :two_auth_code, :string
  end
end
