class NewsController < ApplicationController
  before_filter :require_news_writer, :except => [:index, :show]
  before_filter :require_user, :only => [:show]

  def index
     @news = News.in_language(I18n.locale).all(:limit => 3, :order => "created_at desc")
  end

  def show
    @news = News.find_by_language_and_cross_language_id(I18n.locale, params[:id])
    redirect_to news_index_path if @news.blank?
  end

  def new
    @news = News.new
    @news.cross_language_id ||= params[:localization] if params.has_key? :localization
    @news.language ||= params[:language] if params.has_key? :language
    @news.language ||= I18n.locale.to_s
  end

  def create
    @news = News.new(params[:news])
    # TODO news belongs to language
    #@news.language ||= Language.find_by_code(I18n.locale)
    #@news.language ||= I18n.locale.to_s

    if @news.save
      begin
        FileUtils.mv params[:news][:image].path, @news.image_fullpath
      rescue
      end

      params[:tags].each_pair do |key, tag_params|
        label = tag_params[:label]
        tag = nil
        begin
          tag ||= Tag.find_by_label(label)
        rescue
        end
        begin
          tag ||= Tag.find_by_id(label)
        rescue
        end
        tag ||= Tag.create(:label => label) if not tag and not label.blank?
        @news.tags << tag if tag
      end
      redirect_to news_path(:id => @news.cross_language_id)
    else
      render :action => "new"
    end
  end

  def edit
    @news = News.find(params[:id])
  end

  def update
    @news = News.find(params[:id])
    @news.update_attributes(params[:news])
    if @news.save
      begin
        if not params[:news][:image].blank?
          FileUtils.mv params[:news][:image].path, @news.image_fullpath
        end
      rescue
      end
      params[:tags].each_pair do |key, tag_params|
        label = tag_params[:label]
        tag = nil
        begin
          tag ||= Tag.find_by_label(label)
        rescue
        end
        begin
          tag ||= Tag.find_by_id(label)
        rescue
        end
        tag ||= Tag.create(:label => label) if not tag and not label.blank?
        @news.tags << tag if tag
      end
      redirect_to news_path(:id => @news.cross_language_id)
    else
      render :action => "edit"
    end
  end
end
