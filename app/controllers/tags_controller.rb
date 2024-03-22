class TagsController < ApplicationController
  before_action :authenticate_request

  # GET /tags
  def index
    tags = Tag.all
    render json: TagBlueprint.render(tags), status: :ok
  end

  # POST /tags
  def create
    tag = Tag.new(tag_params)

    if tag.save
      render json: TagBlueprint.render(tag), status: :ok
    else
      render json: tag.errors, status: :unprocessable_entity
    end
  end

  def tag_params
    params.permit(:name)
  end
end
