class Playlist < ActiveRecord::Base
belongs_to :user
has_many :playlistmusics
has_many :musics, through: :playlistmusics

def user_playlists
  # self.all.map{|playlist| playlist.name}
end

end
