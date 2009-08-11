class NewsController < ApplicationController
  def index
    @news = News.in_language(I18n.locale).all(:limit => 3, :order => "created_at desc")
  end

  def show
    @news = News.find_by_language_and_cross_language_id(I18n.locale, params[:id])
    redirect_to news_index_path if @news.blank?
  end

  def new
    @news = News.new
  end

  def create
    @news = News.new(params[:news])
    # TODO news belongs to language
    #@news.language ||= Language.find_by_code(I18n.locale)
    @news.language ||= I18n.locale.to_s

    if @news.save
      begin
        FileUtils.mv params[:news][:image].path, @news.image_fullpath
      end
      redirect_to news_path(:id => @news.cross_language_id)
    else
      render :action => "new"
    end
  end
end
