class CreateMusics < ActiveRecord::Migration[5.2]
  def change
    create_table :musics do |t|
      t.integer     :cd_id
      t.string      :audio_id
      t.string      :musit_title
      t.timestamps
    end
  end
end
