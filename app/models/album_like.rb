class AlbumLike < ActiveRecord::Base
	belongs_to :users
	belongs_to :albums
end