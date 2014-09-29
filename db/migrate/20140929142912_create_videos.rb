class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :tiitle
      t.integer :episode
      t.integer :season
    end
  end

  def self.down
    drop_table :videos
  end
end

