class AddContactAndSiteToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :contact, :string, null: true
    add_column :users, :site, :string, null: true
  end
end
