class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    case user
    when User
      if user.manager?
        can :manage, User, company_id: user.company_id
        can :create, Company
        can :manage, Workspace, company_id: user.company_id
        can :manage, Department, company_id: user.company_id
        can :manage, Position
        can :manage, Project, company_id: user.company_id
        can :manage, PositionType, company_id: user.company_id
        can :manage, Skill, company_id: user.company_id
        can :manage, UserSkill
      else
        can [:read, :update], User, id: user.id
        can :read, Workspace, company_id: user.company_id
      end
    when Admin
      can :manage, :all
    end
  end
end
