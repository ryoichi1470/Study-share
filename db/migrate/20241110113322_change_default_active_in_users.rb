class ChangeDefaultActiveInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :active, from: false, to: true
    User.update_all(active: true)
  end
end
