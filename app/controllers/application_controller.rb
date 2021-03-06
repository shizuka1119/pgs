class ApplicationController < ActionController::Base
  before_action:set_current_user
  before_action:set_current_admin

  #ログインユーザーの特定
  def set_current_user
     @current_user = User.find_by(id: session[:user_id])
  end

  #ログインしていないと使用不可
  def authenticate_user
    if @current_user ==nil
       flash[:notice] = "Login required"
       redirect_to login_path
    end
  end

  #ログイン中は使用不可
  def forbid_login_user
    if @current_user
       flash[:notice] = "Logged in"
       redirect_to items_path
    end
  end

  #ログイン中の管理者の特定
  def set_current_admin
     @current_admin = Admin.find_by(id: session[:admin_id])
  end

  #ログイン中は使用不可
  def forbid_login_admin
    if @current_admin
       flash[:notice] = "Logged in"
       redirect_to items_path
    end
  end

end