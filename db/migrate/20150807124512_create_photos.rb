class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.string :instagram_photo_id
      t.string :image_url
      t.string :latitude
      t.string :longitude
    end
  end
end
