class SkillsController < ApplicationController
  load_and_authorize_resource

  def index
    @skills = Skill.of_company(current_user.company_id).alphabet.
      page(params[:page]).per Settings.pagination.per_page
  end

  def show
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new skill_params
    if @skill.save
      flash[:success] = t "flash.success.created_skill"
      redirect_to skills_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @skill.update_attributes skill_params
      flash[:success] = t "flash.success.updated_skill"
      redirect_to skills_path
    else
      render :edit
    end
  end

  private
  def skill_params
    params.require(:skill).permit(:name).
      merge! company_id: current_user.company_id
  end
end
