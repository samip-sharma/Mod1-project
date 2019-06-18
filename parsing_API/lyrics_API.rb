require "rest-client"
require "pry"
require "json"

def lyricsAPI(artist, song)
  artist = artist.split(" ").join("_")
  song=song.split(" ").join("_")
  url = "https://private-anon-fa9f05909e-lyricsovh.apiary-proxy.com/v1/#{artist}/#{song}"
  lyrics_data = RestClient.get(url)
  hash = JSON.parse(lyrics_data.body)
  return hash["lyrics"]
end


# "lyricssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss".each_char { |letter| print(letter); sleep(0.2) }
