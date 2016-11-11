class AddAvatarsToPositionTypes < ActiveRecord::Migration[5.0]
  def self.up
    change_table :position_types do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :position_types, :avatar
  end
end
