class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.integer :cross_language_id, :null => false
      t.string :title, :null => false
      t.string :bajada, :null => false
      t.text :text, :null => false
      t.string :language, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :news
  end
end
