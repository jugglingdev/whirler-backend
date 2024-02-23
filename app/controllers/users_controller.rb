class UsersController < ApplicationController
  before_action :authenticate_request, only: [:show, :update, :destroy]

  # POST /users (Sign Up view)
  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # GET /profile (Profile view)
  def show
    render json: UserBlueprint.render(@current_user, view: :profile_edit), status: :ok
  end

  # PUT /profile (Profile view - Update)
  def update
    if @current_user.update(user_params)
      render json: UserBlueprint.render(@current_user, view: :profile_edit), status: :ok
    else
      render json: @current_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /profile (Profile view - Delete)
  def destroy
    if @current_user.destroy
      render json: nil, status: :ok
    else
      render json: @current_user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
  end
end
