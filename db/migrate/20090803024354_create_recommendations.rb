class CreateRecommendations < ActiveRecord::Migration
  def self.up
    create_table :recommendations do |t|
      t.integer :subscriber_user_id, :null => false
      t.string :email, :null => false
      t.boolean :sent, :default => false
    end
  end

  def self.down
    drop_table :recommendations
  end
end
