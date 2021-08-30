# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show followings followers]

  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show; end

  def followers
    @followers = @user.followers.with_attached_avatar.order(:email).page(params[:page])
  end

  def followings
    @followings = @user.followings.with_attached_avatar.order(:email).page(params[:page])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
