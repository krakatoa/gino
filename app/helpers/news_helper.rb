module NewsHelper
  def link_to_news(news)
    link_to_unless_current news.title, logged_in? ? news_path(:id => news.cross_language_id) : signup_path
  end
end
