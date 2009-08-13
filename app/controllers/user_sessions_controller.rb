class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]  # in ApplicationController
  before_filter :require_user, :only => :destroy            # in ApplicationController
  
  def new
    @user_session = UserSession.new
  end

  def create
    if params[:user_session][:username] =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
      begin
        user = SubscriberUser.find_by_email(params[:user_session][:username])
        @user_session = UserSession.create(user)
      rescue
      end
    end
    if not @user_session
      @user_session = UserSession.new(params[:user_session])
    end
		if user || (@user_session.valid? and @user_session.save)
      language = user.language if user
      language ||= User.find_by_username(@user_session.username).language if @user_session.username
      language ||= I18n.locale
      redirect_back_or_default news_index_url(:locale => language)
		else
      flash[:notice] = @user_session.errors.on("base") if @user_session.errors.on("base")
      redirect_back_or_default root_url
		end
	end

	def destroy
		current_user_session.destroy
    session[:return_to] = nil
		redirect_to root_url
	end
end
