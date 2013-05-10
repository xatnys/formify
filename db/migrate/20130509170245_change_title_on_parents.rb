class ChangeTitleOnParents < ActiveRecord::Migration
  def change
  	change_column :parents, :title, :string, :default => "none"
  end
end
