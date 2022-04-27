class AddSlugToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :slug, :string, after: :name
  end
end
