class User < ActiveRecord::Base
has_many :playlists
has_many :playlistmusics, through: :playlists
has_many :musics, through: :playlistmusics
end
