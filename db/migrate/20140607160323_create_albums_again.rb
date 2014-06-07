class CreateAlbumsAgain < ActiveRecord::Migration
  def change
    create_table :albums do |t|
    	t.string :title
    	t.string :band
    	t.date :release
    end
  end
end
