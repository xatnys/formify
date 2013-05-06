class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :email
      t.string :addr
      t.string :city
      t.string :state
      t.integer :zip, limit: 12
      t.integer :reg_method, limit: 1
      t.boolean :confirmed?, default: true

      t.timestamps
    end
  end
end
