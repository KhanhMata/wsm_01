class CreatePositionTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :position_types do |t|
      t.string :name
      t.text :description
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
