class AddRegIndexToParent < ActiveRecord::Migration
  def change
  	add_index :parents, :reg_method
  end
end
