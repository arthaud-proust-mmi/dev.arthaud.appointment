class ChangePlannedAtToDateFromMeets < ActiveRecord::Migration[7.0]
  def change
    change_column :meets, :planned_at, :date
  end
end
