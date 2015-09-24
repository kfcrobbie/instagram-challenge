class PicturesController < ApplicationController

before_action :authenticate_user!, :except => [:index, :show]

  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if @picture.save
     redirect_to '/pictures'
   else
     render 'new'
   end
  end

  def show
    current_picture
  end

  def edit
    current_picture
    if current_user === @picture.user
      current_picture
    else
      flash[:notice] = "Only the creator can edit this picture"
      redirect_to '/pictures'
    end
  end

  def update
    current_picture
    @picture.update(picture_params)

    redirect_to '/pictures'
  end

  def destroy
    current_picture
    if current_user === @picture.user
      @picture.destroy
      flash[:notice] = 'Picture deleted successfully'
      redirect_to '/pictures'
    else
      flash[:notice] = 'Only the creator can delete this picture'
      redirect_to '/pictures'
    end
  end

  def picture_params
    params.require(:picture).permit(:image, :title)
  end

  def current_picture
    @picture = Picture.find(params[:id])
  end
end
