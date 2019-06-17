require "rest-client"
require "pry"
require "json"

def lyricsAPI(artist, song)
  url = "https://private-anon-fa9f05909e-lyricsovh.apiary-proxy.com/v1/#{artist}/#{song}"
  lyrics_data = RestClient.get(url)
  hash = JSON.parse(lyrics_data)
  return hash["lyrics"]
end
