class UserSkill < ApplicationRecord
  belongs_to :user
  belongs_to :skill

  validates :experience_years, presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 0}
end
