class AddAdressToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :adress, :string, null: true
  end
end
