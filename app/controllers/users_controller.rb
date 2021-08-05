# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show]

  # GET /users
  # GET /userss.json
  def index
    @users = User.order(:id).page(params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
end
