class AdminsController < ApplicationController
  #ログイン中は使用不可！
  before_action:forbid_login_admin,{only: [:new, :create, :login_form, :login]}

  def index
  	@admins = Admin.all
  end

  def new
  	@admin = Admin.new
  end

  def show
    @admin = Admin.find(params[:id])
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
       session[:admin_id] = @admin.id
       flash[:notice] = "管理者登録が完了しました"
       redirect_to admin_path(@admin.id)
    else
      redirect_to new_admin_path
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.update(admin_params)
       flash[:notice] = "管理者情報を編集しました"
      redirect_to admin_path(@admin.id)
    else
      redirect_to edit_admin_path(@admin.id)
    end
  end

  def destory
    @admin = Admin.find(params[:id])
    @admin.destory
    redirect_to("/")
  end

  def login_form
  end

  def login
    @admin = Admin.find_by(name: params[:name],password: params[:password])
    if @admin
      session[:admin_id] = @admin.id
      flash[:notice] = "Login"
      redirect_to admin_path(@admin.id)
    else
      @error_message = "Error"
      @name = params[:name]
      @password = params[:password]
      redirect_to a_login_path
      byebug
    end
  end

  def logout
    session[:admin_id] = nil
    flash[:notice] = "Logout"
    redirect_to a_login_path
  end

  private
  def admin_params
    params.require(:admin).permit(:name,:email,:password,:profile_image)
  end
end
