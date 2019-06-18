class Playlist < ActiveRecord::Base
belongs_to :user
belongs_to :music

def display_all_playlists
  self.all.map{|playlist| playlist.name}
end

end
