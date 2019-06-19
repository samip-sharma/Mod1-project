class Music < ActiveRecord::Base
has_many :playlistmusics
has_many :playlists, through: :playlistmusics
# belongs_to :user, through: :playlists
end
