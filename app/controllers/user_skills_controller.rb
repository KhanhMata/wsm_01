class UserSkillsController < ApplicationController
  load_and_authorize_resource
  before_action :load_users_and_skills, only: [:new, :edit]

  def new
    @user_skill = UserSkill.new
  end

  def create
    @user_skill = UserSkill.new user_skill_params
    if @user_skill.save
      flash[:success] = t "flash.success.created_user_skill"
      redirect_to :back
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user_skill.update_attributes user_skill_params
      flash[:success] = t "flash.success.updated_user_skill"
      redirect_to :back
    else
      render :edit
    end
  end

  def destroy
    if @user_skill.destroy
      flash[:success] = t "flash.success.deleted_user_skill"
    else
      flash[:danger] = t "flash.danger.delete_user_skill"
    end
    redirect_to :back
  end

  private
  def user_skill_params
    params.require(:user_skill).permit(:experience_years, :user_id, :skill_id)
  end

  def load_users_and_skills
    @users = User.of_company(current_user.company_id)
    @skills = Skill.of_company(current_user.company_id)
  end
end
