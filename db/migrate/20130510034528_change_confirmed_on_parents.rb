class ChangeConfirmedOnParents < ActiveRecord::Migration
  def change
  	change_column :parents, :is_confirmed, :int, :default => 1
  	rename_column :parents, :is_confirmed, :confirmed_status
  end
end
