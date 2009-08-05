class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]  # in ApplicationController
  before_filter :require_user, :only => :destroy            # in ApplicationController
  
  def new
    @user_session = UserSession.new
  end

  def create
		@user_session = UserSession.new(params[:user_session])
		if @user_session.valid? and @user_session.save
      redirect_back_or_default news_index_url
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
