class MakeDefaultActiveForStudents < ActiveRecord::Migration[5.1]
  def change
    change_column :students, :active, :boolean, default:true 
  end
end
