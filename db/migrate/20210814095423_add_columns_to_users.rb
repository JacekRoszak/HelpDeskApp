class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :cell_number, :string
    add_column :users, :work_number, :string
    add_column :users, :inner_number, :string
    add_column :users, :position, :string
  end
end
