class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
    :validatable
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

  scope :newest, ->{order created_at: :desc}
end
