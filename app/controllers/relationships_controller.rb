# frozen_string_literal: true

class RelationshipsController < ApplicationController
  def create
    @other_user = User.find(params[:user_id])
    current_user.follow(@other_user)
    redirect_to user_path(@other_user)
  end

  def destroy
    @other_user = Relationship.find_by(id: params[:id], follower_id: current_user.id).followed
    current_user.unfollow(@other_user)
    redirect_to user_path(@other_user)
  end
end
