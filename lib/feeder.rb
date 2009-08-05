# ISO 3166 Country Codes: http://www.maxmind.com/app/iso3166
# Please note that "EU" and "AP" codes are only used when a specific country code has not been designated (see FAQ).
# Blocking or re-directing by "EU" or "AP" will only affect a small portion of IP addresses.
# Instead, you should list the countries you want to block/re-direct individually.

RAILS_HOME = File.expand_path(File.join(File.dirname(__FILE__),"..")) if not defined? RAILS_HOME
require RAILS_HOME + "/config/environment"

class Feeder
  def self.feed_country_names
    CountryName.destroy_all

    country_names = File.open(File.join(DATA_DIR,'country_names.dat'), "r")
    country_names.readline
    for c in country_names
      country = c.split(",\"").collect{|c| c.gsub("\"","").chomp}
      CountryName.create!(:code => country[0].downcase,
                          :en => country[1],
                          :es => country[2])
    end
  end
end
