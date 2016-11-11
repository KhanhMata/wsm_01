class PositionTypesController < ApplicationController
  load_and_authorize_resource

  def index
    @position_types = PositionType.of_company(current_user.company_id).alphabet.
      page(params[:page]).per Settings.pagination.per_page
  end

  def show
  end

  def new
    @position_type = PositionType.new
  end

  def create
    @position_type = PositionType.new position_type_params
    if @position_type.save
      flash[:success] = t "flash.success.created_position_type"
      redirect_to position_types_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @position_type.update_attributes position_type_params
      flash[:success] = t "flash.success.updated_position_type"
      redirect_to position_types_path
    else
      render :edit
    end
  end

  private
  def position_type_params
    params.require(:position_type).permit(:name, :description, :avatar).
      merge! company_id: current_user.company_id
  end
end
