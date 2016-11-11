class Company < ApplicationRecord
  has_many :users
  has_many :departments, dependent: :destroy
  has_many :workspace, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_many :projects, dependent: :destroy
end
