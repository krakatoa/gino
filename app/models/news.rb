class News < ActiveRecord::Base
  acts_as_textiled :text

  after_create :create_news_localizations

  belongs_to :news_localizations, :foreign_key => "cross_language_id"
  has_one :es, :through => :news_localizations
  has_one :en, :through => :news_localizations
  has_and_belongs_to_many :tags

  validates_presence_of :title, :text, :language

  named_scope :in_language, lambda { |lang| { :conditions => { :language => lang } } }

  attr_accessor :image

  def initialize(attributes=nil)
    super
    self.cross_language_id ||= (NewsLocalizations.count + 1)
  end

  def image_fullpath
    File.join(IMAGES_PATH, self.image_filename)
  end

  def image_path
    if File.exists? image_fullpath
      return self.image_filename
    else
      return nil
    end
  end

  def image_filename
    "#{self.id}.jpg"
  end
  
  def traeme_una_puntita
    max = 10 # cantidad de palabras
    palabras = self.text.split(" ")
    cant_palabras = palabras.size
    puntita = palabras[0..max - 1].join(" ")
    puntita.concat("...") if cant_palabras > max
    return puntita
  end

  def other_available_languages
    Language.available_languages.select{|l| l != Language.find_by_code(self.language).code}
  end

  def other_languages
    # TODO se podra hacer con menos queries ?

    other_languages = []
    self.other_available_languages.each do |language|
      other_languages << language unless self.news_localizations.read_attribute("#{language}_id").blank?
    end
    other_languages
  end

  def missing_languages
    missing_languages = []
    self.other_available_languages.each do |language|
      missing_languages << language if self.news_localizations.read_attribute("#{language}_id").blank?
    end
    missing_languages
  end

  private
    def create_news_localizations
      begin
        asigned_news_localizations = NewsLocalizations.find(self.cross_language_id)
      rescue
        asigned_news_localizations = NewsLocalizations.create
      end
      asigned_news_localizations.write_attribute("#{self.language.to_sym}_id", self.id)
      asigned_news_localizations.save
    end
end
