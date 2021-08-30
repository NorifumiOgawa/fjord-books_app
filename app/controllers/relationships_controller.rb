# frozen_string_literal: true

class RelationshipsController < ApplicationController
  def create
    @other_user = User.find(params[:user_id])
    if current_user.follow(@other_user)
      redirect_to user_path(@other_user)
    else
      redirect_to user_path(@other_user), alert: t('errors.template.header.one', model: Relationship.model_name.human)
    end
  end

  def destroy
    @other_user = current_user.active_relationships.find(params[:id]).followed
    current_user.unfollow(@other_user)
    redirect_to user_path(@other_user)
  end
end
