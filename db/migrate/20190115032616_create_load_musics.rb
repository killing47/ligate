class CreateLoadMusics < ActiveRecord::Migration[5.2]
  def change
    create_table :load_musics do |t|
      t.integer     :cd_id
      t.integer     :user_id
      t.timestamps
    end
  end
end
