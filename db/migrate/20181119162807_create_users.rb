class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :hashed_password
      t.boolean :active, default: false
      t.string :activation_token
      t.timestamp :activated_at
      t.timestamps
    end
  end
end
