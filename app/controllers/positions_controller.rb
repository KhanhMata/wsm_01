class PositionsController < ApplicationController
  before_action :load_position, only: [:edit, :update]

  def edit
    @staff_positions = Position.of_workspace(@position.workspace_id).
      position_staff
    @users = User.user_without_position(@staff_positions)
  end

  def update
    @workspace = @position.workspace
    if @position.staff?
      if @position.update_attributes position_params
        @position.update_user_position
        flash[:success] = t "flash.success.updated_workspace"
        redirect_to :back
      else
        render :edit
      end
    else
      if @position.update_attributes position_params
        flash[:success] = t "flash.success.updated_workspace"
        redirect_to :back
      else
        render :edit
      end
    end
  end

  private
  def position_params
    params.require(:position).permit :name, :description,
      :status, :user_id, :desk_code
  end

  def load_position
    @position = Position.find_by id: params[:id]
    unless @position
      flash.now[:danger] = t "flash.danger.position_not_found"
      redirect_to :back
    end
  end
end
