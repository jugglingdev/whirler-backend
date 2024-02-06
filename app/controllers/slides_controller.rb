class SlidesController < ApplicationController
    before_action :set_slide, only: [:show, :update, :destroy]

    def index
        slides = Slide.all
        render json: slides, status: 200
    end

    def show
        render json: @slide, status: 200
    end

    def create
        slide = Slide.new(slide_params)

        if slide.save
            render json: slide, status: :created
        else
            render json: slide.errors, status: :unprocessable_entity
        end
    end

    def update
        if @slide.update(slide_params)
            render json: @slide, status: :ok
        else
            render json: @slide.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @slide.destroy
            render json: nil, status: :ok
        else
            render json: @slide.errors, status: :unprocessable_entity
        end
    end

    def carousels_index
        slide = Slide.find(params[:slide_id])

        slide_carousels = slide.carousels
            render json: slide_carousels, status: :ok
    end

    private

    def set_slide
        @slide = Slide.find(params[:id])
    end

    def slide_params
        params.permit(:title, :carousel_id)
    end
end
