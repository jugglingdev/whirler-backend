class SlidesController < ApplicationController
    before_action :authenticate_request
    before_action :set_slide, only: [:show, :update, :destroy]

    # GET /carousels/:carousel_id/slides (Carousel Edit view)
    def slides_index
        carousel = @current_user.carousels.find(params[:id]);
        render json: CarouselBlueprint.render(carousel, view: :carousel_edit), status: :ok
    end

    # GET /slides/:id (Carousel Edit view)
    def show
        render json: @slide, status: :ok
    end

    # POST carousel/:id/slides (Carousel Edit view - Create)
    def create
        carousel = @current_user.carousels.find(params[:carousel_id]);
        slide = carousel.slides.new(slide_params)
        
        if slide.save
            render json: slide, status: :created
        else
            render json: slide.errors, status: :unprocessable_entity
        end
    end

    # PUT /slides/:id (Carousel Edit view - Update)
    def update
        if @slide.update(slide_params)
            render json: @slide, status: :ok
        else
            render json: @slide.errors, status: :unprocessable_entity
        end
    end

    # DELETE /slides/:id (Carousel Edit view - Delete)
    def destroy
        if @slide.destroy
            render json: nil, status: :ok
        else
            render json: @slide.errors, status: :unprocessable_entity
        end
    end

    private

    def set_slide
        @slide = Slide.find(params[:id])
    end

    def slide_params
        params.permit(:title, :carousel_id)
    end
end
