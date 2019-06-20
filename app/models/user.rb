class User < ActiveRecord::Base
has_many :playlists
has_many :playlistmusics, through: :playlists
has_many :musics, through: :playlistmusics


  def playlists_name
    self.playlists.map{|playlist| playlist.name}
  end

  def musics_name
    self.musics.map{|music| music.name}
  end

  def playlist_name_with_music_id(music_id)
    self.playlistmusics.select{|plm| plm.music_id==music_id}[0]
  end
end
