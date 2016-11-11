class Company < ApplicationRecord
  has_many :users
  has_many :departments
  has_many :workspace
  has_many :skills
  has_many :projects
  has_many :position_types
end
