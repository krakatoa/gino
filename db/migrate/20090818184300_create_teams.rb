class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :name, :null => false
      t.integer :tag_id, :null => false
      t.timestamps
    end

    # Atlantico
    Team.create!(:name => "Boston Celtics")
    Team.create!(:name => "New Jersey Nets")
    Team.create!(:name => "Nueva York Knicks")
    Team.create!(:name => "Philadelphia 76ers")
    Team.create!(:name => "Toronto Raptors")
    # Centro
    Team.create!(:name => "Chicago Bulls")
    Team.create!(:name => "Cleveland Cavaliers")
    Team.create!(:name => "Detroit Pistons")
    Team.create!(:name => "Indiana Pacers")
    Team.create!(:name => "Milwaukee Bucks")
    # Sureste
    Team.create!(:name => "Atlanta Hawks")
    Team.create!(:name => "Charlotte Bobcats")
    Team.create!(:name => "Miami Heat")
    Team.create!(:name => "Orlando Magic")
    Team.create!(:name => "Washington Wizards")
    # Suroeste
    Team.create!(:name => "Dallas Mavericks")
    Team.create!(:name => "Houston Rockets")
    Team.create!(:name => "Memphis Grizzlies")
    Team.create!(:name => "New Orleans Hornets")
    Team.create!(:name => "San Antonio Spurs")
    # Noroeste
    Team.create!(:name => "Denver Nuggets")
    Team.create!(:name => "Minnesota Timberwolves")
    Team.create!(:name => "Oklahoma City SuperSonics")
    Team.create!(:name => "Portland Trailblazers")
    Team.create!(:name => "Utah Jazz")
    # Pacifico
    Team.create!(:name => "Golden State Warriors")
    Team.create!(:name => "Los Angeles Clippers")
    Team.create!(:name => "Los Angeles Lakers")
    Team.create!(:name => "Phoenix Suns")
    Team.create!(:name => "Sacramento Kings")
  end

  def self.down
    drop_table :teams
  end
end
