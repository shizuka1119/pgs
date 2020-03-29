class UsersController < ApplicationController
  #ログインしていないと使用不可！
  before_action:authenticate_user,{only:[:show, :update]}
  #ログイン中は使用不可！
  before_action:forbid_login_user,{only: [:new, :create, :login_form, :login]}
  #本人でないと編集不可！
  before_action:ensure_correct_user,{only: [:update]}

  def index
  	@users = User.all
  end

  def new
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
    @items = @user.items
  end

  def like
    @user = User.find(params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def following
    @user = User.find(params[:id])
    @relationships = Relationship.where(user_id: @user.id)
  end

  def follower
    @user = User.find(params[:id])
    @relationships = Relationship.where(follow_id: @user.id)
  end

  def create
    @user = User.new(user_params)
    if @user.save
       session[:user_id] = @user.id
       flash[:notice] = "Sign in Complete"
      redirect_to user_path(@user.id)
    else
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "Edit Complete"
      redirect_to user_path(@user.id)
    else
      redirect_to edit_user_path(@user.id)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to("/")
  end

  def login_form
  end

  def login
    @user = User.find_by(name: params[:name],password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "Login"
      redirect_to user_path(@user.id)
    else
      @error_message = "Error"
      @name = params[:name]
      @password = params[:password]
      redirect_to login_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logout"
    redirect_to login_path
  end

    #本人でないと編集不可
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
    flash[:notice] = "Unauthorized"
    redirect_to items_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:email,:password,:profile_image)
  end

end