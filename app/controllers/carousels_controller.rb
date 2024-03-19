class CarouselsController < ApplicationController
    before_action :authenticate_request
    before_action :set_carousel, only: [:show, :update, :destroy]

    # GET /carousels (Dashboard view)
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
        new_carousel_tags = params[:tags]

        if new_carousel_tags
          new_carousel_tags.count.times do | i |
            carousel.tags.create(name: new_carousel_tags[i])
          end
        end

        render json: CarouselBlueprint.render(carousel, view: :dashboard), status: :created
      else
        render json: carousel.errors, status: :unprocessable_entity
      end
    end
  
    # PUT /carousels/:id (Carousel Edit view - Update)
    def update
      if @carousel.update(carousel_params)
        new_carousel_tags = params[:tags]
        new_carousel_tags.count.times do | i |
          @carousel.tags.create(name: new_carousel_tags[i])
        end

        render json: CarouselBlueprint.render(@carousel, view: :dashboard), status: :ok
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
  
    private
  
    def set_carousel
      @carousel = Carousel.find(params[:id])
    end
  
    def carousel_params
      params.permit(:title, :description, :thumbnail, :user_id, tag_ids: [])
    end
end
