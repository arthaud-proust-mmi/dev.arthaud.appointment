class CreateMeets < ActiveRecord::Migration[7.0]
  def change
    create_table :meets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.datetime :planned_at

      t.timestamps
    end
  end
end
