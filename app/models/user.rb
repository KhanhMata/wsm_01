class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
    :validatable, :registerable

  belongs_to :company
  belongs_to :department

  has_one :position
  has_many :project_members
  has_many :projects, through: :project_members
  has_many :user_skills
  has_many :skills, through: :user_skills

  enum gender: {female: 0, male: 1, other: 3}
  enum role: {manager: 0, user: 1}
  validates :name, presence: true, length: {maximum: 50}

  validates :name, presence: true, length: {maximum: 50}

  scope :newest, ->{order created_at: :desc}
  scope :of_department, -> department_id {where(department_id: department_id)}
  scope :of_company, -> company_id {where(company_id: company_id)}
  scope :staff_with_department, -> {group :department_id}

  def set_manager_company company_id
    self.update company_id: company_id
  end

  def set_user_company company_id
    self.update company_id: company_id
  end
end
