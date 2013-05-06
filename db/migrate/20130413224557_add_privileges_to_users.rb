class AddPrivilegesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :privileges, :integer, :default => 0, :null => false
  end
end
