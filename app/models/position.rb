class Position < ApplicationRecord
  belongs_to :user
  belongs_to :workspace
  belongs_to :position_type

  scope :coordinates, ->column, row {where column: column, row: row}

  enum status: {disabled: 0, freedesk: 1, staff: 2, freespace: 3}
  scope :coordinates, -> (i, j) {where(column: j, row: i)}
  scope :name_or_deskcode, ->search do
    joins(:user).where "users.name LIKE ? OR desk_code LIKE ?",
      "%#{search}%", "%#{search}%"
  end
  scope :of_workspace, -> workspace_id {where workspace_id: workspace_id}
  scope :position_staff, -> {where.not user_id: nil}
  scope :user_position, -> user_id {where user_id: user_id}
  scope :remove_user_id, -> {update user_id: nil, status: 3}
  scope :except_position, -> id {where.not id: id}

  def update_user_position
    unless self.staff?
      self.update user_id: nil
    end
  end
end
