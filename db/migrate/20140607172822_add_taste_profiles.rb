class AddTasteProfiles < ActiveRecord::Migration
  def change
    create_table :taste_profiles do |t|
      t.string :name
      t.integer :echonest_id
      t.integer :user_id

      t.timestamps
    end
  end
end
