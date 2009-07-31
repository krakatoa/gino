class NewsController < ApplicationController
  def index
    @news = News.in_language(I18n.locale)
  end

  def show
    @news = News.find_by_language_and_cross_language_id(I18n.locale, params[:id])
  end
end
