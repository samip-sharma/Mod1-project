require "tty-prompt"
require "pry"

def tty_menus

system 'clear'
    prompt = TTY::Prompt.new
    prompt.select("Choose What you wanna do?") do |menu|
      menu.choice 'Create playlist' => -> do  create_playlist end
      menu.choice 'Display my playlists'=> -> do  display_all_playlists end
      menu.choice 'Delete Playlist', -> do  display_playlists_to_delete end
      menu.choice 'Search for a song to Play', -> do  play_now_user_req_song end
      menu.choice 'EXIT' => -> do  exit_program end
      # menu.choice 'All my songs'=> -> do  all_my_songs end

      # menu.choice 'Delete playlist', 2
    end
end

def play_now_user_req_song
  puts "LETS HAVE SOME BEATS"
  puts ""
  puts "Enter artist name:"
  artist=gets.chomp
  puts "Enter song name:"
  song_name=gets.chomp
  puts "Have fun DUDE 🤬🤬🤬"

   music1=MusicAPI.new(artist, song_name)
   puts lyricsAPI(music1.artist_name,music1.song_title)
   play_music(music1.song_preview)
   begin
   display_picture(music1.cover_picture)
   p music1.song_preview
 rescue
   ask_to_save(artist, song_name)
 end
end

def ask_to_save(artist, song_name)
    prompt = TTY::Prompt.new
  answer=prompt.yes?('Do you wanna save this song to a playlist?')
  if answer

    puts "Choose the playlist to save in:"
    userr=User.find_by(id:$user)
    userr.playlists_name.each {|playlist| puts playlist}
    user_input=gets.chomp
    if !userr.playlists_name.include?(user_input)
      puts "You dont have that play list"
      ask_to_save(artist, song_name)
    else
      existing_playlist=Playlist.find_by(name:user_input)
      new_playlistmusic=Playlistmusic.create
      existing_playlist.playlistmusics << new_playlistmusic
      new_music=Music.create(title:song_name, artist:artist)
      new_music.playlistmusics << new_playlistmusic
      tty_menus
      end
    else
      tty_menus

  end
end

def display_playlists_to_delete
userr=User.find_by(id:$user)
  if userr.playlists[0].nil?
    system 'clear'
  puts  "You don't have any playlist, Create one Dummy!!!💩💩💩"
  puts ""
  puts ""
     tty_menus
   end
  arr=  userr.playlists.map{|playlist|  playlist.name}

    ttying_display_playlists_to_delete(arr)
end

def ttying_display_playlists_to_delete(arr)
  prompt = TTY::Prompt.new
  prompt.select("All playlists") do |menu|
    arr.each do |el|
    menu.choice "#{el}" => -> do  delete_now_playlist(el) end

    end
    menu.choice "back" => -> do  exit_program end
  end
end


def delete_now_playlist(name)
  pl=Playlist.find_by(name: name)
  pl.destroy
tty_menus
end

    def create_playlist
      userr=User.find_by(id:$user)
      puts "Creating Playlist For you 💽💽💽"
      puts ""
      puts "Enter Playlist Name:"
      playlist_name=gets.chomp

      arr=userr.playlists_name

      if !arr.include?(playlist_name)

        play=Playlist.create(name:playlist_name)
        userr.playlists << play
        tty_menus

      else
      system 'clear'
        puts "Playlist already exists, Try another name. "
        create_playlist
      end
    end

    def display_all_playlists
      userr=User.find_by(id:$user)
      if userr.playlists[0].nil?
      system 'clear'
      puts  "You don't have any playlist, Create one Dummy!!!💩💩💩"
      puts ""
      puts ""
         tty_menus
       end
    arr=  userr.playlists.map{|playlist|  playlist.name}
      tty_displaying_playlists(arr)
    end


    def tty_displaying_playlists(arr)
      prompt = TTY::Prompt.new
      prompt.select("All playlists") do |menu|
        arr.each do |el|
        menu.choice "#{el}" => -> do  show_music_from_playlist(el) end
        end
        menu.choice "Go back" => -> do  tty_menus end
      end
    end



    def show_music_from_playlist(playlist_name)
      play=Playlist.find_by(name: playlist_name)
      arr=play.musics.map{|music| music.title}
      tty_displaying_musics(arr)
    end


    def tty_displaying_musics(arr)
      begin
      prompt = TTY::Prompt.new
      prompt.select("All Musics") do |menu|
        arr.each do |el|
        menu.choice "#{el}" => -> do  play_now_music(el) end
        end
      end
    rescue
      puts "no music BRO ADD SOME music to playlist or just play sOmething"
      tty_menus
    end
    end


    def play_now_music(el)
      music_now=Music.find_by(title:el)
       music1=MusicAPI.new(music_now.artist, music_now.title)
       puts lyricsAPI(music1.artist_name,music1.song_title)
       begin
       play_music(music1.song_preview)
       music1.song_preview

       display_picture(music1.cover_picture)
     rescue
       ask_to_stay?
      end
      end

      def ask_to_stay?
        prompt = TTY::Prompt.new
        puts "if you wanna keep lisning to music just press nothing."
        answer=prompt.yes?('press y to go to menu')
        if answer
          tty_menus
        else
          exit_program
        end
      end



    def all_my_songs
      userr=User.find_by(id:$user)
      user.musics.map{|music| puts "#{music.artist}: #{music.title}"}
      nil
    end

    def exit_program
    puts  "See ya later👋✋🏼✌🏽"
    end



# create_playlist
