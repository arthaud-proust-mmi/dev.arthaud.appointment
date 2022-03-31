class AddIsProToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_pro, :boolean, null: false, default: false
    add_index :users, :is_pro
  end
end
