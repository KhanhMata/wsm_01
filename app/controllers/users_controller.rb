class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :skip_password_attribute, only: :update
  before_action :change_position_status, only: :destroy

  def index
    @users = User.of_company(current_user.company_id).newest.
      page(params[:page]).per Settings.users_paginates
  end

  def show
    @user_skills = @user.user_skills
  end

  def new
    @user = User.new
  end

  def edit
    if @user.company
      @departments = @user.company.departments
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "flash.success.updated_user"
      redirect_to @user
    else
      render :edit
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      if user_signed_in?
        if current_user.company
          @user.set_manager_company current_user.company_id
        else
          @user.destroy
        end
      end
      flash[:success] = t "flash.success.created_user"
      redirect_to users_path
    else
      render :new
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "flash.success.deleted_user"
    else
      flash[:danger] = t "flash.danger.deleted_user"
    end
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :gender, :birthday, :password,
      :password_confirmation, :role, :department_id, :avatar
  end

  def skip_password_attribute
    if params[:user][:password].blank? &&
      params[:user][:password_confirmation].blank?
      params[:user].delete :password
      params[:user].delete :password_confirmation
    end
  end

  def change_position_status
    @position = Position.user_position(@user)
    @position.remove_user_id
  end
end
