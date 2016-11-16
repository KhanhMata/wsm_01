class Project < ApplicationRecord
  belongs_to :company

  has_many :project_members
  has_many :users, through: :project_members

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :name, presence: true,
    length: {maximum: Settings.maximum.projects.name}
  validates :abbreviation, presence: true,
    length: {maximum: Settings.maximum.projects.abbreviation}

  scope :newest, ->{order created_at: :desc}
end
