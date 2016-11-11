class PositionType < ApplicationRecord
  belongs_to :company

  has_many :positions
  has_attached_file :avatar, :styles => { :thumb => "100x100#" },
    :default_url => "/images/:style/dfpositiontype.jpg"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates :name, presence: true, length: {maximum: 50}

  scope :alphabet, ->{order :name}
  scope :of_company, -> company_id {where(company_id: company_id)}
end
