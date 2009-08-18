# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user_session, :current_user, :current_country_code, :current_country_name
  helper_method :logged_in?, :is_news_writer?, :is_admin?
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  layout "altidus"
  
  before_filter :set_locale

  def set_locale
    params[:locale] ||= extract_locale_from_accept_language_header
    if not Language.available_languages.include? params[:locale].to_s
      params[:locale] = nil
    end
    I18n.locale = params[:locale]
    
    # if params[:locale] is nil then I18n.default_locale will be used (en locale=)
    I18n.locale = I18n.locale.to_s
    I18n.locale ||= :es
  end

  def default_url_options(options={})
    { :locale => I18n.locale.to_sym }
  end

  private
    def extract_locale_from_accept_language_header
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def require_user
      unless current_user
        store_location
        redirect_to signup_url
        return false
      end
    end

    def require_news_writer
      if not current_user or not current_user.is_a? NewsWriterUser
        store_location
        redirect_to root_url
        return false
      end
    end

    def require_admin
      if not current_user or not current_user.is_a? AdminUser
        store_location
        redirect_to root_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You are already logged in"
        redirect_to root_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    def logged_in?
      current_user
    end

    #def deny_access
    #  redirect_to root_url
    #  return false
    #end

    #def get_user
    #  @user = User.find(params[:user_id]) if params.has_key?(:user_id)
    #  @user ||= @current_user
    #end

    def authorize_user
      if @user.nil? and not current_user.is_a? AdminUser
        # TODO check if we can rewrite the URL and scope the resources
        # only for the current_user, instead of redirecting
        redirect_to root_url
      end
    end

    def is_news_writer?
      current_user.is_a? NewsWriterUser
    end

    def is_admin?
      current_user.is_a? AdminUser
    end

    def current_country_code
      if USE_GEOIP
        GEOIP.country(request.remote_ip)[3].downcase
      else
        "ar"
      end
    end

    def current_country_name
      CountryName.find_by_code(current_country_code).send(I18n.locale)
    end
end
