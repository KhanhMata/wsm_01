class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :skip_password_attribute, only: :update

  def index
    @users = User.newest.page(params[:page]).per Settings.users_paginates
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "flash.success.updated_user"
      redirect_to current_user
    else
      render :edit
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "flash.success.created_user"
      redirect_to root_path
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
      :password_confirmation, :role
  end

  def skip_password_attribute
    if params[:user][:password].blank? &&
      params[:user][:password_confirmation].blank?
      params[:user].delete :password
      params[:user].delete :password_confirmation
    end
  end
end
