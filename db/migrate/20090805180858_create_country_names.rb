class CreateCountryNames < ActiveRecord::Migration
  def self.up
    create_table :country_names do |t|
      t.string :code, :null => false
      t.string :es, :null => false
      t.string :en, :null => false
    end
    add_index :country_names, [:code]
    Feeder.feed_country_names
  end

  def self.down
    drop_table :country_names
  end
end
