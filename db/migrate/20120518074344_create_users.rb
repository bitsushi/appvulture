class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, limit: 100, allow_null: false
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :state, limit: 20, allow_null: false
      t.string :auth_token
      t.string :password_reset_token
      t.string :password_reset_sent_at

      t.timestamps
    end
    add_index :users, :email
    add_index :users, :state
  end
end
