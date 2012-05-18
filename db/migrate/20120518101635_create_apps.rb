class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name, limit: 100
      t.string :mid, limit: 40
      t.money :price
      t.string :currency, limit: 3, default: 'GBP'
      t.money :high
      t.money :low
      t.money :avg
      t.string :type, limit: 7, allow_null: false
      t.integer :watcher_count, default: 0
      t.timestamps
    end

    add_index :apps, :name
    add_index :apps, :mid
    add_index :apps, [:id, :type]
  end
end
