class AddStateToMeets < ActiveRecord::Migration[7.0]
  def change
    add_column :meets, :state, :integer, :default => 0
  end
end
