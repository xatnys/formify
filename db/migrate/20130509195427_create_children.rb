class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.references :parent, index: true
      t.string :first_name
      t.string :last_name
      t.datetime :birth_date

      t.timestamps
    end
  end
end
