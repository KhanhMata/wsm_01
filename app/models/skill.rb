class Skill < ApplicationRecord
  belongs_to :company

  has_many :user_skills
  has_many :users, through: :users

  validates :name, presence: true, length: {maximum: 50}

  scope :alphabet, ->{order :name}
  scope :of_company, -> company_id {where(company_id: company_id)}
end
