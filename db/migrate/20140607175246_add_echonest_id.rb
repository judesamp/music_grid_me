class AddEchonestId < ActiveRecord::Migration
  def change
    add_column :taste_profiles, :echonest_id, :string
  end
end
