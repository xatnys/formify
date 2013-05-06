class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.references :parent, index: true
      t.string :number
      t.integer :phone_type

      t.timestamps
    end
  end
end
