class AddTechniciansToDepartments < ActiveRecord::Migration[6.1]
  def change
    add_column :departments, :technicians?, :boolean, default: false
  end
end
