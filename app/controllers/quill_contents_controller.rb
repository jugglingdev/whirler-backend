class QuillContentsController < ApplicationController
        
  before_action :set_quill_contents, only: [:show, :update, :destroy]

  # GET /quill_contents/:id (Carousel Edit view)
  def show
    render json: @quill_contents, status: :ok
  end

  # POST /quill_contents (Carousel Edit view - Create)
  def create
    quill_contents = QuillContent.new(quill_contents_params)

    if quill_contents.save
      render json: quill_contents, status: :created
    else
      render json: quill_contents.errors, status: :unprocessable_entity
    end
  end

  # PUT /quill_contents/:id (Carousel Edit view - Update)
  def update
    if @quill_contents.update(quill_contents_params)
      render json: @quill_contents, status: :ok
    else
      render json: @quill_contents.errors, status: :unprocessable_entity
    end
  end

  # DELETE /quill_contents/:id (Carousel Edit view - Delete)
  def destroy
    if @quill_contents.destroy
      render json: nil, status: :ok
    else
      render json: @quill_contents.errors, status: :unprocessable_entity
    end
  end

  private

  def set_quill_contents
    @quill_contents = QuillContent.find(params[:id])
  end

  def quill_contents_params
    params.permit(:width, :height, :x, :y, :delta, :slide_id)
  end
end
