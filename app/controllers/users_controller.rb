
class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create, :register]           # in ApplicationController
  before_filter :require_user, :except => [:new, :create, :register]            # in ApplicationController
  before_filter :authorize_user, :except => [:new, :create, :register, :update]

  def index
    @users = User.all
  end

  def create
    @subscriber_user = SubscriberUser.new(params[:subscriber_user]) # We use GUI only for creation of Customers
    @subscriber_user.country ||= current_country_code
    @subscriber_user.language = I18n.locale.to_s

    if @subscriber_user.save_without_session_maintenance
      @subscriber_user.deliver_activation_instructions!
      flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
      redirect_to news_index_url
    else
      render :action => :new
    end
  end

  def new
    @subscriber_user = SubscriberUser.new
  end

  def show
    @user = @current_user
  end

  def my_account; edit; end
  def edit
    @user = @current_user
  end

  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      #flash[:notice] = "Account updated!"
      redirect_to root_url
    else
      render :action => :edit
    end
  end

  private
    def authorize_user
      begin
        @user = User.find(params[:id])
        if @user.nil? or (@user != current_user and not current_user.is_a? AdminUser)
          redirect_to root_path
        end
      rescue
        @user = @current_user
      end
    end
end
