class ProjectsController < ApplicationController
  load_and_authorize_resource

  def index
    @projects = Project.of_company(current_user.company_id).newest.
      page(params[:page]).per Settings.pagination.project_per_page
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new project_params
    if @project.save
      redirect_to projects_path
    else
      render :new
    end
  end

  def update
    if @project.update_attributes project_params
      flash.now[:success] = t "flash.success.updated_project"
      redirect_to projects_path
    else
      flash.now[:danger] = t "flash.danger.updated_project"
      render :edit
    end
  end

  def destroy
    if @project.destroy
      flash.now[:success] = t "flash.success.deleted_project"
    else
      flash.now[:danger] = t "flash.danger.deleted_project"
    end
    redirect_to projects_path
  end

  private
  def project_params
    params.require(:project).permit(:name, :abbreviation,
      :start_date, :end_date).merge!(company_id: current_user.company_id)
  end
end
