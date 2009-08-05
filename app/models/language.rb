class Language < ActiveRecord::Base
  validates_presence_of :code

  @@languages = Language.all.collect(&:code)
  def self.available_languages; @@languages; end

  private
end
