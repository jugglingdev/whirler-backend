class CarouselsController < ApplicationController
    before_action :set_carousel, only: [:show, :update, :destroy]

    def index
      carousels = Carousel.all
      render json: carousels, status: 200
    end
  
    def show
      render json: @carousel, status: 200
    end
  
    def create
      carousel = Carousel.new(carousel_params)
  
      if carousel.save
        render json: carousel, status: :created
      else
        render json: carousel.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @carousel.update(carousel_params)
        render json: @carousel, status: :ok
      else
        render json: @carousel.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      if @carousel.destroy
        render json: nil, status: :ok
      else
        redner json: @carousel.errors, status: :unprocessable_entity
      end
    end
  
    def posts_index
      carousel = Carousel.find(params[:carousel_id])
  
      carousel_posts = carousel.posts
      render json: carousel_posts, status: :ok
    end
  
    private
  
    def set_carousel
      @carousel = Carousel.find(params[:id])
    end
  
    def carousel_params
      params.permit(:title, :description)
    end
end
