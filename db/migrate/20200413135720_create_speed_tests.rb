class CreateSpeedTests < ActiveRecord::Migration[6.0]
  def change
    create_table :speed_tests do |t|
      t.string :ping
      t.string :upload
      t.string :download
      t.string :server

      t.timestamps
    end
  end
end
