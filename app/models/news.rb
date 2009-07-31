class News < ActiveRecord::Base
  belongs_to :news_localizations, :foreign_key => "cross_language_id"
  has_one :es, :through => :news_localizations
  has_one :en, :through => :news_localizations

  validates_presence_of :title, :text, :language

  named_scope :in_language, lambda { |lang| { :conditions => { :language => lang } } }

  #def initialize(attributes=nil)
    # si me pasa una news en los atributos, que me tome el cross_language_id
  #end
end
