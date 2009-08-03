class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :label, :null => false
    end
    add_index :tags, :label
  end

  def self.down
    drop_table :tags
  end
end
