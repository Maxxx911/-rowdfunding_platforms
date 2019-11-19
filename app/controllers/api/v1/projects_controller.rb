module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :project_params, only: %i[create]
      before_action :project_params_for_update, only: %i[update]
      before_action :set_project_with_user_token, only: %i[update destroy]
      before_action :set_project, only: %i[show]

      def index
        render json: { success: true, errors: {}, result: { projects: serialize_resource(find_project_with_filters) } }
      end

      def create
        @project = Project.new(title: project_params[:title],
                               description: project_params[:description],
                               end_time: project_params[:end_time],
                               sum_goal: project_params[:sum_goal],
                               current_sum: project_params[:current_sum],
                               image_url: project_params[:image_url],
                               owner: User.find_by(token: project_params[:user_token]),
                               categories: Category.find(project_params[:categories_id])
                              )
        if @project.save
          render json: { success: true, errors: {}, result: { project: serialize_resource(@project) } }
        else
          render json: { success: false, errors: @project.errors.messages, result: {} }
        end
      end

      def update
        if @project
          if @project.update(project_params_for_update)
            render json: { success: true, errors: {}, result: { project: serialize_resource(@project) } }
          else
            render json: { success: false, errors: @project.errors.messages, result: {} }
          end
        else
          render json: { success: false, errors: { project: "Project with id #{params[:id]} not found" }, result: {} }
        end
      end

      def destroy
        if @project
          if @project.delete
            render json: { success: true, errors: {}, result: {} }
          else
            render json: { success: false, errors: @project.errors.messages, result: {} }
          end
        else
          render json: { success: false, errors: { project: "Project with id #{params[:id]} not found" }, result: {} }
        end
      end

      def show
        if @project
          render json: { success: true, errors: {}, result: { project: serialize_resource(@project) } }
        else
          render json: { success: false, errors: { project: "Project with id #{params[:id]} not found" }, result: {} }
        end
      end

      private

      def find_project_with_filters
        ActiveRecord::Base.transaction do
          @projects = Project.all
          @projects = @projects.where('title LIKE ?', "%#{params[:title]}%") if params[:title].present?
          @projects = @projects.where('description LIKE ?', "%#{params[:description]}%") if params[:description].present?
          @projects = @projects.where('end_time < ?', params[:end_time]) if params[:end_time].present?
          @projects = find_project_with_category(eval(params[:categories_id])) if params[:categories_id].present?
        end
        @projects
      end

      def find_project_with_category(category_ids)
        projects = []
        @projects.each do |project|
          next unless (project.category_ids - category_ids).count < project.category_ids.count

          projects << project
        end
        projects
      end

      def project_params
        params.permit(:title, :description, :end_time,
                      :sum_goal, :current_sum, :image_url,
                      :user_token, categories_id: [])
      end

      def project_params_for_update
        params.permit(:title, :description, :end_time,
                      :sum_goal, :current_sum, :image_url,
                      categories_id: [])
      end

      def set_project_with_user_token
        @project = Project.find_by(id: params[:id], owner: User.find_by(token: params[:user_token]))
      end

      def set_project
        @project = Project.find(params[:id])
      end
    end
  end
end
