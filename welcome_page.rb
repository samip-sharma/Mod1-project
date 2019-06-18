require "tty-prompt"
require "pry"


# def tty_home
#   home_logo
#   system "say 'Welcome to MusicIron'"
#   TTY::Prompt.new.select("Welcome to Dank Trivia".red.bold) do |menu|
#     menu.choice "Login" => -> do create_playlist end
#     menu.choice "Create User" => -> do tty_create_user end
#     menu.choice "Quick Play" => -> do tty_guest end
#     menu.choice "High Scores" => -> do high_scores end
#     menu.choice "Close Program".red => -> do abort("See you later dude.") end
#   end
# end
#
# def create_playlist
# puts "SAMIP"
# end


# prompt = TTY::Prompt.new
# prompt.select("Choose What you wanna do?") do |menu|
#   menu.choice 'Create playlist', => -> do  create_Playlist end
#   menu.choice 'Play Song', 2
#   menu.choice 'My playlist', -> { 'Nice choice captain!' }
#   menu.choice 'Delete song from playlist', 2
#   menu.choice 'Delete playlist', 2
# end

def create_playlist
  puts "Creating Playlist For you 💽💽💽"
  puts "Enter Playlist Name:"
  playlist_name=gets.chomp
  if !Playlist.find_by(name: playlist_name)
    Playlist.create(name:playlist_name)
  else
    puts "Playlist already exists, Try another name. "
  end
end

def display_all_playlists
  $user.user_playlists
end





# create_playlist
