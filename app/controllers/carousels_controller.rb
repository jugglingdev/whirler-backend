class CarouselsController < ApplicationController
    before_action :authenticate_request, only: [:create]
    before_action :set_carousel, only: [:show, :update, :destroy]

    # GET /carousels (Dashboard view)
    def index
      carousels = Carousel.all
      render json: CarouselBlueprint.render(carousels, view: :dashboard), status: :ok
    end
  
    # GET /carousels/:id (Carousel Edit view)
    def show
      render json: CarouselBlueprint.render(@carousel, view: :carousel_edit), status: :ok
    end
  
    # POST /carousels (Dashboard view - Create)
    def create
      carousel = Carousel.new(carousel_params)
  
      if carousel.save
        render json: CarouselBlueprint.render(carousel, view: :dashboard), status: :created
      else
        render json: carousel.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH /carousels/:id (Carousel Edit view - Update)
    def update
      if @carousel.update(carousel_params)
        render json: CarouselBlueprint.render(@carousel, view: :carousel_edit), status: :ok
      else
        render json: @carousel.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /carousels/:id (Carousel Edit view - Delete)
    def destroy
      if @carousel.destroy
        render json: nil, status: :ok
      else
        render json: @carousel.errors, status: :unprocessable_entity
      end
    end

    # GET /carousels/:carousel_id/slides (Carousel Edit view)
    def slides_index
      carousel = Carousel.find(params[:carousel_id])
  
      carousel_slides = carousel.slides
      render json: carousel_slides, status: :ok
    end
  
    private
  
    def set_carousel
      @carousel = Carousel.find(params[:id])
    end
  
    def carousel_params
      params.permit(:title, :description, :thumbnail, :user_id, :tags)
    end
end
