class UsersController < ApplicationController
  #before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.save do |result|
      if result
        # Connect twitter/facebook details
        session[:oauth_request_class] = nil # stop authlogic_oauth from registering with twitter a 2nd time
        @user.twitter_connect
        flash[:notice] = "authorisation complete"
      else
        unless @user.oauth_token.nil?
          @user = User.find_by_oauth_token(@user.oauth_token)
          unless @user.nil?
            UserSession.create(@user)
            flash[:notice] = "hello #{@user.login}"
          end
        end
      end
      redirect_to play_url
    end
  end
    
  def show
    @user = @current_user
  end
 
  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "account updated"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end
