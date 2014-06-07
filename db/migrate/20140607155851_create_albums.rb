class CreateAlbums < ActiveRecord::Migration
  # def change
  #   create_table :albums do |t|
  #   	t.string :title
  #   	t.string :band
  #   	t.date :release
  #   end
  # end
  def change
    create_table :album_likes do |t|
    	t.integer :user_id
    	t.integer :album_id
    	t.text :user_comment
    	t.integer :rating
    end
  end
end
