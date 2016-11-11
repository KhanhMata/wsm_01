class DepartmentsController < ApplicationController
  load_and_authorize_resource

  def index
    @users_size = User.of_company(current_user.company_id).
      staff_with_department.size
    @departments = Department.of_company(current_user.company_id).
      page(params[:page]).per Settings.pagination.per_page
  end

  def show
    @users = User.of_department(@department).newest.
      page(params[:page]).per Settings.pagination.users_paginates
  end

  def new
    @department = Department.new
  end

  def edit
  end

  def update
    if @department.update_attributes department_params
      flash[:success] = t "flash.success.updated_department"
      redirect_to departments_path
    else
      render :edit
    end
  end

  def create
    @department = Department.new department_params
    if @department.save
      flash[:success] = t "flash.success.created_department"
      redirect_to departments_path
    else
      render :new
    end
  end

  private
  def department_params
    params.require(:department).permit(:name, :abbreviation, :description).
      merge! company_id: current_user.company_id
  end
end
