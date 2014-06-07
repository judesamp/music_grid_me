class RemoveEchonestId < ActiveRecord::Migration
  def change
    remove_column :taste_profiles, :echonest_id, :integer
  end
end
