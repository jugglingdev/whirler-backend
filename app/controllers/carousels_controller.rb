class CarouselsController < ApplicationController
    before_action :authenticate_request
    before_action :set_carousel, only: [:show, :update, :destroy]

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
  
    # PUT /carousels/:id (Carousel Edit view - Update)
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
      slides_with_quill_contents = carousel.slides.includes(:quill_contents)
      render json: SlideBlueprint.render(slides_with_quill_contents, view: :carousel_edit), status: :ok
    end
  
    private
  
    def set_carousel
      @carousel = Carousel.find(params[:id])
    end
  
    def carousel_params
      params.permit(:title, :description, :thumbnail, :user_id, tags: [ :name ] )
    end
end
