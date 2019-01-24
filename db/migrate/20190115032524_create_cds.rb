class CreateCds < ActiveRecord::Migration[5.2]
  def change
    create_table :cds do |t|

      t.string     :cd_title, default: "SampleCd"
      t.string     :cd_image_id
      t.string     :cd_genre, default: "SampleGenre"
      t.integer    :user_id
      t.timestamps
    end
  end
end
