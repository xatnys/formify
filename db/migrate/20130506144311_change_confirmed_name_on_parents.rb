class ChangeConfirmedNameOnParents < ActiveRecord::Migration
  def change
  	rename_column :parents, :confirmed?, :is_confirmed
  end
end
