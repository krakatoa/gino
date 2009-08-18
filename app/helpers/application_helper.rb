# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def nombre_idioma(language)
  # TODO Usar Language
  
    case language.to_s
    when "es"
      nombre_idioma = "spanish"
    when "en"
      nombre_idioma = "english"
    else
      nombre_idioma = "spanish"
    end
    t(nombre_idioma)
  end

  def country_names_collection(lang=I18n.locale)
    CountryName.all(:order => "#{lang} asc").collect{|c| [c.send(lang), c.code]}
  end

  def languages_collection()
    Language.all.collect{|l| [nombre_idioma(l.code), l.code]}
  end

  def tags_collection
    Tag.all.collect{|t| [t.label, t.id]}
  end

  def year_of_birth_collection
    ((Time.now.year - 99)..Time.now.year).to_a.reverse
  end

  def load_last_news
    @last_news = News.in_language(I18n.locale).all(:order => "created_at desc", :limit => 5)
  end

  def main
    content_tag(:div, yield, {:id => "main"})
  end

  def html_title(title="")
    html_title = "Altidus"
    if not title.blank?
      html_title << " - #{title}"
    end
    content_for :page_title do
      html_title
    end
  end
end
