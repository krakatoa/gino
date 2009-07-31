class NewsLocalizations < ActiveRecord::Base
  belongs_to :es, :foreign_key => "es_id", :class_name => "News"
  belongs_to :en, :foreign_key => "en_id", :class_name => "News"
end
