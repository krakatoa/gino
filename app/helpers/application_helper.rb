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

  def load_last_news
    @last_news = News.in_language(I18n.locale).all(:order => "created_at desc", :limit => 5)
  end

  def main
    content_tag(:div, yield, {:id => "main"})
  end
end
