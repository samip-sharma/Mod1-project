require "tty-prompt"

prompt = TTY::Prompt.new

#[0] Prompt app user for their name
user_name = prompt.ask("What is your name?", default: "full name")

#[1] Search Database for a User instance with User.name == (passed in user_name)
user_found = User.find_by(name: user_name)

#----------------------------------------------

#[2] If such User instance was found, welcome the user back and ask if they would like to add a new song to their play list (Y/n)
#[2a] If yes, prompt the user for artist name and song title, and pass those to the APIs to print the lyrics, cover art, and launch song preview. Then go to step 3
#[2b] If no, user doesn't want to add a song to playlist, also go to step 3
if user_found
 puts "Welcome Back"
 if prompt.yes?("Would you like to add a song to your playlist?")
   puts "Enter an artist name:"
   artist = gets.chomp
   puts "Enter a song name from that artist:"
   song = gets.chomp

   puts lyricsAPI_slow_print(artist, song)
   music_data = MusicAPI.new(artist, song)
   puts music_data.cover_picture
   play_music(music_data.song_preview)
 end
 #[3a] If playlist of user_name is not empty, display <artist, music title> for all the songs in playlist of user_name as a list of options in TTY prompt, asking the user which song to play. Also include an option to exit and go back to step 0. Selecting a song should pass artist name and song title to APIs to print the lyrics, cover art, and launch song preview. Then re-run step 3

 #[3b] If playlist of user_name is empty then prompt user to "Add song to playlist", and run step 2a

else
 #[4a] If such User instance was not found, create user instance with User.name = (passed in user_name) and go to step 3b
 User.name = user_name
end
