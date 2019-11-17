class Api::V1::ProjectsController < ApplicationController
  before_action :project_params, only: %i[create update]
  before_action :set_project, only: %i[update]

  def index
    render json: { success: true, errors: {}, result: { projects: serialize_resource(Project.all)} }
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
      render json: { success: true, errors: {}, result: {project: @project } }
    else
      render json: { success: false, errors: @project.errors.messages, result: {} }
    end
  end

  def update
    if @project
      if @project.update(project_params)
        render json: { success: true, errors: {}, result: {project: @project } }
      else
        render json: { success: false, errors: @project.errors.messages, result: {} }
      end
    else
      render json: { success: false, errors: { project: "Project with #{params[:id]} not found"}, result: {} }
    end
  end

  def delete
  end

  private

  def project_params
    params.permit(:title, :description, :end_time,
                  :sum_goal, :current_sum, :image_url,
                  :user_token, categories_id: [] )
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
