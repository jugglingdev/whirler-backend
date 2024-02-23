class CarouselsController < ApplicationController
    before_action :authenticate_request
    before_action :set_carousel, only: [:show, :update, :destroy]

    # GET /dashboard (Dashboard view)
    def index
      user_carousels = @current_user.carousels
      render json: CarouselBlueprint.render(user_carousels, view: :dashboard), status: :ok
    end

    # GET /carousels/:id (Carousel Edit view)
    def show
      render json: CarouselBlueprint.render(@carousel, view: :carousel_edit), status: :ok
    end
  
    # POST /carousels (Dashboard view - Create)
    def create
      carousel = @current_user.carousels.new(carousel_params)

      if carousel.save
        new_carousel_tags = params[:new_tags]
        new_carousel_tags.count.times do | i |
          carousel.tags.create(name: new_carousel_tags[i])
        end

        render json: CarouselBlueprint.render(carousel, view: :dashboard), status: :created
      else
        render json: carousel.errors, status: :unprocessable_entity
      end
    end
  
    # PUT /carousels/:id (Carousel Edit view - Update)
    def update
      if @carousel.update(carousel_params)
        new_carousel_tags = params[:new_tags]
        new_carousel_tags.count.times do | i |
          @carousel.tags.create(name: new_carousel_tags[i])
        end

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
      render json: SlideBlueprint.render(carousel, view: :carousel_edit), status: :ok
    end
  
    private
  
    def set_carousel
      @carousel = Carousel.find(params[:id])
    end
  
    def carousel_params
      params.permit(:title, :description, :thumbnail, :user_id, tag_ids: [])
    end
end
