class ItemsController < ApplicationController
  #ログインしていないと使用不可！
  before_action:authenticate_user,{only:[:show, :edit, :update, :destory]}
  #本人でないと編集不可！
  before_action:ensure_correct_user,{only: [:edit, :update, :destory]}

  def index
      @items = Item.all
  end

  def show
  	  @item = Item.find(params[:id])
      @like = Like.new
  end

  def new
  	  @item = Item.new
  end

  def create
  	  @item = Item.new(item_params)
      @item.user_id = @current_user.id
  	  if @item.save
         flash[:notice] = "Note Create"
  	     redirect_to item_path(@item)
      else
         render("items/new")
      end
  end

  def edit
  	  @item = Item.find(params[:id])
  end

  def update
      @item = Item.find(params[:id])
      @item.update(item_params)
      redirect_to item_path
  end

  def destroy
  	  @item = Item.find(params[:id])
  	  @item.destroy
  	  redirect_to items_path
  end

  def ensure_correct_user
    @item = Item.find_by(id: params[:id])
    if @item.user_id != @current_user.id
       flash[:notice] = "Unauthorized"
       redirect_to items_path
    end
  end

  private
  def item_params
      params.require(:item).permit(:title, :category, :body)
  end

end
