class AddColumnToEmployee < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :departmentname, :string
    add_column :employees, :isactive, :boolean
    add_column :employees, :name, :string
    add_column :employees, :contactno, :string
    add_column :employees, :totalattendance, :integer
  end
end
