class PrototypesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :destoroy]
  before_action :find_params, only: [:show, :edit, :update]

  def index
    @prototypes = Prototype.includes(:user)
  end
  

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end


  def edit
    toppage_redirect
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype.id)
    else
      render :edit
    end
  end


  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def find_params
    @prototype = Prototype.find(params[:id])
  end

  def toppage_redirect
    unless current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end

end
