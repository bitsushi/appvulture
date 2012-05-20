class CreateAndroids < ActiveRecord::Migration
  def change
    create_table :androids do |t|

      t.timestamps
    end
  end
end
