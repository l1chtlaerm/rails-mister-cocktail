class CocktailsController < ApplicationController
  require 'open-uri'

  before_action :find_cocktail, only: %i(show)

  def index
    @cocktails = Cocktail.all
  end

  def show
    @dose = Dose.new
    @review = Review.new
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.photo = source_img unless @cocktail.photo.attached?
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  private

  def source_img
    Cloudinary::Uploader.upload("https://source.unsplash.com/random/?#{@cocktail.name}+cocktail")
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end

  def find_cocktail
    @cocktail = Cocktail.find(params[:id])
  end
end
