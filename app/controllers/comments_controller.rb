# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      @book = @commentable
      render template: "#{@comment.imageable_type.downcase}s/show"
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.imageable, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.imageable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params[:id], user_id: current_user.id)
    redirect_to root_path unless @comment
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end