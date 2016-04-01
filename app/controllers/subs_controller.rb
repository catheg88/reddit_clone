class SubsController < ApplicationController
  before_action :require_current_user!, except: [:index, :show]
  # before_action :require_moderator!(params), only: [:edit, :update, :destroy]

  def index
    @subs = Sub.all
    render :index
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    
    if @sub.save
      render :show
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def new
    @sub = Sub.new
    render :new
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update_attributes(sub_params)
      render :show
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    sub = Sub.find(params[:id])
    sub.destroy
    render :new
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
