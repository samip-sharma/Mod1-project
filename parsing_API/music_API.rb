require "rest-client"
require "pry"
require "json"

## To Do: Refactor this code to be encapsulated in a class

$song_title = ""
$song_preview = ""
$artist_name = ""
$cover_picture = ""

def musicAPI(artist, song)
  artist = artist.split(" ").join("_")
  song = song.split(" ").join("_")
  url = "https://api.deezer.com/search?q=#{artist}_#{song}"
  music_data = RestClient.get(url)
  hash = JSON.parse(music_data)
  $song_title = hash["data"][0]["title"]
  $song_preview = hash["data"][0]["preview"]
  $artist_name = hash["data"][0]["artist"]["name"]
  $cover_picture = hash["data"][0]["artist"]["picture_big"]
  # binding.pry
end

def music_Preview
  $song_preview
end
