class CreateLenses < ActiveRecord::Migration
  def change
    create_table :lenses do |t|
      t.references :watcher
      t.references :app
      t.integer :rule, default: 0, limit: 1
      t.money :initial_price
      t.money :desired_price, default: 0
      t.timestamps
    end
    add_index :lenses, [:app_id, :watcher_id], unique: true
    # add_index :lenses, [:app_id, :desired_price, :rule]
  end
end
