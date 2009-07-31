class CreateNewsLocalizations < ActiveRecord::Migration
  def self.up
    create_table :news_localizations do |t|
      t.integer :es_id
      t.integer :en_id
    end
  end

  def self.down
    drop_table :news_localizations
  end
end
