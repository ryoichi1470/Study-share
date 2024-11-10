class AddActiveToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :active, :boolean, default: false
    add_column :users, :status, :string
    add_column :users, :confirmation, :string
  end
end
