class NewsTags < ActiveRecord::Migration
  def self.up
    create_table :news_tags, :id => false do |t|
      t.integer :tag_id
      t.integer :news_id
    end
  end

  def self.down
    drop_table :news_tags
  end
end
