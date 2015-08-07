class AddInstagramToUsers < ActiveRecord::Migration
  def change
    add_column :users, :instagram_id, :integer
    add_column :users, :instagram_access_token, :string
  end
end
