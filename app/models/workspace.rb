class Workspace < ApplicationRecord
  belongs_to :company

  has_many :positions, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.maximum.workspace.name}
  validates :description, presence: true,
    length: {maximum: Settings.maximum.workspace.description}
  validates_numericality_of :number_of_columns, presence: true
  validates_numericality_of :number_of_rows, presence: true
  before_create :create_positions

  scope :newest, ->{order created_at: :desc}
  scope :of_company, -> company_id {where(company_id: company_id)}
  scope :workspace_with_company, -> {group :company_id}

  def increase_positions(rows, columns, increase_rows, increase_columns,
      workspace)
    if (increase_rows >= 0 && increase_columns <0)
      for i in 1..(-increase_columns)
        for j in 1..rows
          workspace.positions.where(column: columns+1-i, row: j)[0].destroy
        end
      end
      columns += increase_columns
      for i in 1..increase_rows
        for j in 1..columns
          workspace.positions.build column: j, row: i+rows
        end
      end
    else
      if (increase_rows >= 0)
        for i in 1..increase_rows
          for j in 1..columns
            workspace.positions.build column: j, row: i+rows
          end
        end
      else
        for i in 1..(-increase_rows)
          for j in 1..columns
            workspace.positions.where(column: j, row: rows+1-i)[0].destroy
          end
        end
      end
      rows += increase_rows
      if(increase_columns >= 0)
        for i in 1..increase_columns
          for j in 1..rows
            workspace.positions.build column: i+columns, row: j
          end
        end
      else
        for i in 1..(-increase_columns)
          for j in 1..rows
            workspace.positions.where(column: columns+1-i, row: j)[0].destroy
          end
        end
      end
    end
  end

  private
  def create_positions
    if self.number_of_columns <= 0
      self.number_of_columns = 1
    end
    if self.number_of_rows <= 0
      self.number_of_rows = 1
    end
    column = self.number_of_columns
    row = self.number_of_rows
    for i in 1..row
      for j in 1..column
        self.positions.build column: j, row: i
      end
    end
  end
end
