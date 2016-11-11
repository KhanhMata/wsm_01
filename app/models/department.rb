class Department < ApplicationRecord
  belongs_to :company

  has_many :users

  scope :alphabet, ->{order :name}

  validates :name, presence: true, length: {maximum: 50}
  validates :abbreviation, presence: true, length: {maximum: 20}

  scope :of_company, -> company_id {where(company_id: company_id)}
end
