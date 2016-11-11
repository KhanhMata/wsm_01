class Position < ApplicationRecord
  belongs_to :workspace
  belongs_to :user

  enum status: {disabled: 0, freedesk: 1, staff: 2, freespace: 3}
  scope :coordinates, -> (i, j) {where(column: j, row: i)}

  def update_user_position
    unless self.staff?
      self.update user_id: nil
    end
  end
end
