class UsersController < ApplicationController
  before_action :authenticate_request, only: [:show, :update, :destroy, :carousels_index]
  before_action :set_user, only: [:show, :update, :destroy]

  # POST /users (Sign Up view)
  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # GET /users/:id (Profile view)
  def show
    render json: UserBlueprint.render(@user, view: :profile_edit), status: :ok
  end

  # PUT /users/:id (Profile view - Update)
  def update
    if @user.update(user_params)
      render json: UserBlueprint.render(@user, view: :profile_edit), status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id (Profile view - Delete)
  def destroy
    if @user.destroy
      render json: nil, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
  end
end
