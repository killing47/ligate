class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string      :provider
      t.string      :uid
      t.string      :name
      t.string      :email
      t.string      :user_image
      t.string      :image_id
      t.string      :oauth_token
      t.datetime    :oauth_expires_at
      t.string      :nick_name,        default: "NickName"
      t.integer     :status,           default: "0"
      t.string      :introduction,     default: ""
      t.timestamps
    end
  end
end
