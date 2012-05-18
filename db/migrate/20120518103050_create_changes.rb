class CreateChanges < ActiveRecord::Migration
  def change
    create_table :changes do |t|
      t.references :app
      t.money :price
      t.datetime :at
    end
    #unique price at
    add_index :changes, :app_id
  end
end
