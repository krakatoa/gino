class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :user_kind, :null => false
      t.string :username
      t.string :email
      t.string :crypted_password
      t.string :password_salt

      t.string :name
      t.string :last_name
      t.integer :birth_year
      t.integer :language

      t.string :persistence_token
      t.string :last_login_ip
      t.string :current_login_ip

      t.string :perishable_token, :default => "", :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
