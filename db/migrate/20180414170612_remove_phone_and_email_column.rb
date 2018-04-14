class RemovePhoneAndEmailColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :instructors, :email
    remove_column :instructors, :phone
  end
end
