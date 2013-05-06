class AddPhoneToParents < ActiveRecord::Migration
  def change
    add_reference :parents, :phone, index: true
  end
end
