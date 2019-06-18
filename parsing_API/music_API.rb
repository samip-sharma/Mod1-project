require "rest-client"
require "pry"
require "json"

class MusicAPI
  attr_reader :artist, :song
  def initialize(artist,song)
    @artist = artist.split(" ").join("_")
    @song=song.split(" ").join("_")
    url = "https://api.deezer.com/search?q=#{@artist}_#{@song}"
    music_data = RestClient.get(url)
    @hash = JSON.parse(music_data.body)
  end


  def song_title
    @hash["data"][0]["title"]
  end


def song_preview
  @hash["data"][0]["preview"]
end
def artist_name
  @hash["data"][0]["artist"]["name"]
end

def cover_picture
  @hash["data"][0]["artist"]["picture_big"]
end

end
