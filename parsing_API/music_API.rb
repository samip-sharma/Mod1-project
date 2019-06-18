require "rest-client"
require "pry"
require "json"

def musicAPI(artist, song)
  artist = artist.split(" ").join("_")
  song = song.split(" ").join("_")
  url = "https://api.deezer.com/search?q=#{artist}_#{song}"
  music_data = RestClient.get(url)
  hash = JSON.parse(music_data)
  song_title = hash["data"][0]["title"]
  song_preview = hash["data"][0]["preview"]
  artist_name = hash["data"][0]["artist"]["name"]
  cover_picture = hash["data"][0]["artist"]["picture_big"]
  binding.pry
end

print musicAPI("John Maus", "Rockets")
