class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :user_kind, :null => false
      t.string :username
      t.string :email
      t.string :crypted_password
      t.string :password_salt

      t.string :name, :default => nil
      t.string :last_name, :default => nil
      t.integer :birth_year, :default => nil
      t.integer :language_id, :null => false
      t.string :country

      t.boolean :active, :default => false, :null => false

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
