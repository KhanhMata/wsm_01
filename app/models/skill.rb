class Skill < ApplicationRecord
  belongs_to :company

  has_many :user_skills, dependent: :destroy
  has_many :users, through: :users
end
