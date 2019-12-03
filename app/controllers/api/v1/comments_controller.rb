module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_comment, only: %i[index update]
      before_action :set_comment_with_user_token, only: %i[destroy]

      def index
        if @comment
          render json: { success: true, errors: {}, result: { comments: serialize_resource(@comment) } }
        else
          render json: { success: false, errors: 'Not found comment', result: {} }
        end
      end

      def create
        user = User.find_by(token: params[:user_token])
        project = Project.find(comment_params[:project_id])
        if user && project
          @comment = Comment.new(text: comment_params[:text], user_id: user.id, project_id: project.id, created_at: DateTime.now)
          if @comment.save
            render json: { success: true, errors: {}, result: { comments: serialize_resource(@comment) } }
          else
            render json: { success: false, errors: @comment.errors.messages, result: {} }
          end
        else
          render json: { success: false, errors: 'Not found project or user', result: {} }
        end
      end

      def destroy
        if @comment
          if @comment.delete
            render json: { success: true, errors: {}, result: {} }
          else
            render json: { success: false, errors: @comment.errors.messages, result: {} }
          end
        else
          render json: { success: false, errors: 'Not found comment', result: {} }
        end
      end

      private

      def comment_params
        params.permit(:text, :user_token, :project_id)
      end

      def set_comment_with_user_token
        user = User.find_by(token: params[:user_token])
        if user && user.role == 'admin'
          @comment = Comment.find_by(project_id: params[:project_id])
        else
          @comment = Comment.find_by(project_id: params[:project_id],
                                     user: user)
        end
      end

      def set_comment
        @comment = Comment.where(project_id: params[:project_id])
      end
    end
  end
end
