class Playlistmusic < ActiveRecord::Base
belongs_to :playlist
belongs_to :music
end
