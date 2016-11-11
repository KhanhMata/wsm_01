class WorkspacesController < ApplicationController
  load_and_authorize_resource

  def index
    @workspaces = Workspace.of_company(current_user.company_id).newest.
      page(params[:page]).per Settings.pagination.per_page
  end

  def new
    @workspace = Workspace.new
  end

  def create
    @workspace = Workspace.new workspace_params
    if @workspace.save
      flash[:success] = t "flash.success.created_workspace"
      redirect_to :back
    else
      flash[:danger] = t "flash.danger.workspaces.created_workspace"
      render :new
    end
  end

  def show
    if params[:workspace_id]
      respond_to do |format|
        format.js
        format.html
      end
      @workspace = Workspace.find_by id: params[:workspace_id]
    end
    @workspaces = Workspace.of_company(current_user.company_id)
    @users_size = Position.of_workspace(@workspace).position_staff.size
    @positions = @workspace.positions
    @positions_search = @positions.name_or_deskcode(params[:search])
  end

  def edit
  end

  def update
    update_number_of_rows
    update_number_of_columns
    if @workspace.update_attributes workspace_params
      if (@workspace.number_of_rows + @rows <= 0)
        @workspace.number_of_rows = - @rows + 1
      end
      if (@workspace.number_of_columns + @columns <= 0)
        @workspace.number_of_columns = - @columns + 1
      end
      @workspace.increase_positions(@rows, @columns, @workspace.number_of_rows,
        @workspace.number_of_columns, @workspace)
      @workspace.update_attribute(:number_of_rows,
        (@workspace.number_of_rows + @rows))
      @workspace.update_attribute(:number_of_columns,
        (@workspace.number_of_columns + @columns))
      flash[:success] = t "flash.success.updated_workspace"
      redirect_to workspaces_path
    else
      render :edit
    end
  end

  def destroy
    if @workspace.destroy
      flash[:success] = t "flash.success.deleted_workspace"
    else
      flash[:danger] = t "flash.danger.deleted_workspace"
    end
    redirect_to workspaces_path
  end

  private
  def update_number_of_rows
    @rows = @workspace.number_of_rows
  end

  def update_number_of_columns
    @columns = @workspace.number_of_columns
  end

  def workspace_params
    params.require(:workspace).permit(:name, :number_of_columns,
      :number_of_rows, :description).merge!(company_id: current_user.company_id)
  end
end
