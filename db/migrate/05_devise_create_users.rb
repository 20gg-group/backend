class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.string :full_name
      t.string :phone_number
      t.attachment :avatar
    
      t.timestamps null: false
    end
    add_index :users, :email,                unique: true
  end
end
