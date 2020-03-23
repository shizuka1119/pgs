class UsersController < ApplicationController
  #ログインしていないと使用不可！
  before_action:authenticate_user,{only:[:edit, :update]}
  #ログイン中は使用不可！
  before_action:forbid_login_user,{only: [:new, :create, :login_form, :login]}
  #本人でないと編集不可！
  before_action:ensure_correct_user,{only: [:edit, :update, :destory]}

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

  def create
    @user = User.new(user_params)
    if @user.save
       session[:user_id] = @user.id
       flash[:notice] = "ユーザー登録が完了しました"
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
       flash[:notice] = "ユーザー情報を編集しました"
      redirect_to user_path(@user.id)
    else
      redirect_to edit_user_path(@user.id)
    end
  end

  def destory
    @user = User.find(params[:id])
    @user.destory
    redirect_to("/")
  end

  def login_form
  end

  def login
    @user = User.find_by(name: params[:name],password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to user_path(@user.id)
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]

      #renderへ修正したい
      redirect_to login_path

    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to login_path
  end

  private
  def user_params
    params.require(:user).permit(:name,:email,:password,:profile_image)
  end


end
