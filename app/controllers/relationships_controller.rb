# frozen_string_literal: true

class RelationshipsController < ApplicationController
  def create
    @other_user = User.find(params[:user_id])
    result = current_user.follow(@other_user)
    if result
      redirect_to user_path(@other_user)
    else
      redirect_to user_path(@other_user), alert: t('errors.template.header.one', model: Relationship.model_name.human)
    end
  end

  def destroy
    @other_user = Relationship.find_by(id: params[:id], follower_id: current_user.id).followed
    result = current_user.unfollow(@other_user)
    if result
      redirect_to user_path(@other_user)
    else
      redirect_to user_path(@other_user), alert: t('errors.template.header.one', model: Relationship.model_name.human)
    end
  end
end
