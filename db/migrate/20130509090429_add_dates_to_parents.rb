class AddDatesToParents < ActiveRecord::Migration
  def change
  	add_column :parents, :tour_date, :datetime
  end
end
