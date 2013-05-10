class CreateDelegations < ActiveRecord::Migration
  def change
    create_table :delegations do |t|
    	t.references :user, index: true
    	t.integer :parent_id
    	t.boolean :status, :default => false
      t.timestamps
    end
  end
end
