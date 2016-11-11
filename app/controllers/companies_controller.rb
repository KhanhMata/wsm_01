class CompaniesController < ApplicationController
  load_and_authorize_resource

  def new
    @company = Company.new
  end

  def create
    @company = Company.new company_params
    if @company.save
      if user_signed_in?
        current_user.set_manager_company @company.id
      else
        @company.destroy
      end
      flash[:success] = t "flash.susscess.created_company"
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def company_params
    params.require(:company).permit :name
  end
end
