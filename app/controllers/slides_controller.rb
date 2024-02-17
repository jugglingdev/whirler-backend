class SlidesController < ApplicationController
    before_action :set_slide, only: [:show, :update, :destroy]

    # GET /slides/:id (Carousel Edit view)
    def show
        render json: @slide, status: :ok
    end

    # POST /slides (Carousel Edit view - Create)
    def create
        slide = Slide.new(slide_params)

        if slide.save
            render json: slide, status: :created
        else
            render json: slide.errors, status: :unprocessable_entity
        end
    end

    # PATCH /slides/:id (Carousel Edit view - Update)
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

    # GET /slides/:slide_id/quill_contents (Carousel Edit view)
    def quill_contents_index
        slide = Slide.find(params[:slide_id])
    
        slide_quill_contents = slide.quill_contents
        render json: slide_quill_contents, status: :ok
    end

    private

    def set_slide
        @slide = Slide.find(params[:id])
    end

    def slide_params
        params.permit(:title, :carousel_id)
    end
end
