class AddEmployeeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :employee, :boolean, default: true, null: false
  end
end
