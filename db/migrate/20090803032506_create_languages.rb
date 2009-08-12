class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.string :code, :null => false
    end
    add_index :languages, [:code]
    Language.create!(:code => "es")
    Language.create!(:code => "en")
  end

  def self.down
    drop_table :languages
  end
end
