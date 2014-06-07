class Album < ActiveRecord::Base
	has_many :album_likes
	has_many :users, through: :album_likes
end