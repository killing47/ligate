class CreateMusics < ActiveRecord::Migration[5.2]
  def change
    create_table :musics do |t|
      t.integer     :cd_id
      t.string      :music_title
      t.timestamps
    end
  end
end
