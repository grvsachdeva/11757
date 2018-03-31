class AddFieldToEmployee < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :isAdmin, :boolean ,:default => false
  end
end
