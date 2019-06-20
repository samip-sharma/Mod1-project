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
        menu.choice 'Delete a song' => -> do delete_now_song end
      menu.choice '👋 EXIT' => -> do  exit_program end
    end
end


def delete_now_song
  userr = User.find_by(id:$user)
  arr=userr.musics.map { |music| music.title }
  ttying_all_songs_to_delete(arr)
end


def ttying_all_songs_to_delete(arr)
  system 'clear'
  prompt = TTY::Prompt.new
  prompt.select("Select a song to delete") do |menu|
    arr.each do |el|
    menu.choice "#{el}" => -> do  delete_song_ok(el) end
    end
    menu.choice "⏪Go back" => -> do  tty_menus end
  end
end

def delete_song_ok(el)
  userr=User.find_by(id:$user)
  current_music_id=Music.find_by(title:el).id
  plm_to_delete=userr.playlist_name_with_music_id(current_music_id)
  plm_to_delete.destroy


  system 'clear'
  puts "Deleted #{el} from your songs"
  sleep 2
  delete_now_song
end





def play_now_user_req_song
  system 'clear'
  puts "LETS HAVE SOME BEATS 🎶 🎧 🎸"
  puts ""
  puts "Enter artist name:"
  artist=gets.chomp
  puts "Enter song name:"
  song_name=gets.chomp

   music1=MusicAPI.new(artist, song_name)
   begin
     system 'clear'
     puts "Searching your music Using satelite in MARS 🌍🌍🌍 "
     puts ''
     puts lyricsAPI(music1.artist_name,music1.song_title)
     play_music(music1.song_preview)
     begin
     display_picture(music1.cover_picture)
    rescue
     ask_to_save(artist, song_name)
    end
  rescue
    puts "Bad song choice try another one ✌🏽✌🏽✌🏽"
    sleep 4
    play_now_user_req_song
  end
end

def ask_to_save(artist, song_name)
    prompt = TTY::Prompt.new
  answer=prompt.yes?('Do you wanna save this song to a playlist?')
  if answer

    puts "Choose the playlist to save in:"
    userr=User.find_by(id:$user)
    arr=userr.playlists_name

    system 'clear'
    prompt = TTY::Prompt.new
    prompt.select("Choose a playlist you wanna save into:") do |menu|
      arr.each do |el|
      menu.choice "#{el}" => -> do  saving_new_song_to_playlist(el,artist,song_name) end
      end
      menu.choice "Cancel 🛑" => -> do  tty_menus end
    end
    # user_input=gets.chomp
    # if !userr.playlists_name.include?(user_input)
    #   puts "You dont have that play list"
    #   ask_to_save(artist, song_name)
    # else
    #   existing_playlist=Playlist.find_by(name:user_input)
    #   new_playlistmusic=Playlistmusic.create
    #   existing_playlist.playlistmusics << new_playlistmusic
    #   new_music=Music.create(title:song_name, artist:artist)
    #   new_music.playlistmusics << new_playlistmusic
    #   tty_menus
    #   end

    else
      tty_menus
  end
end


  def saving_new_song_to_playlist(el,artist,song_name)
    userr=User.find_by(id:$user)
    saving_playlist= userr.playlists.find{|playlist| playlist.name==el}

    plm=Playlistmusic.create
    final_music_arr=Music.all.select{|music| music.artist == artist && music.title== song_name}


    if final_music_arr[0].nil?
      new_music=Music.create(title:song_name, artist:artist)
      new_music.playlistmusics << plm
      saving_playlist.playlistmusics << plm
      plm.save
    else
      saving_playlist.playlistmusics << plm
      final_music_arr[0].playlistmusics << plm
      plm.save

    end

    tty_menus
  end


def display_playlists_to_delete
userr=User.find_by(id:$user)
  if userr.playlists[0].nil?
    system 'clear'
  prompt = TTY::Prompt.new
  prompt.select("Sorry, You don't have any playlist, I am confused what to delete 🤷😕‍") do |menu|
    menu.choice "⏪ Back" => -> do  tty_menus end
    end
   end
  arr=  userr.playlists.map{|playlist|  playlist.name}

    ttying_display_playlists_to_delete(arr)
end


def ttying_display_playlists_to_delete(arr)
  system 'clear'
  prompt = TTY::Prompt.new
  prompt.select("All playlists") do |menu|
    arr.each do |el|
    menu.choice "#{el}" => -> do  delete_now_playlist(el) end

    end
    menu.choice "⏪back" => -> do  tty_menus end
  end
end


def delete_now_playlist(name)
  pl=Playlist.find_by(name: name)
  pl.destroy
tty_menus
end

    def create_playlist
      userr=User.find_by(id:$user)
      system 'clear'
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
        prompt = TTY::Prompt.new
        system 'clear'
        prompt.select("You don't have any playlist, Create one Dummy!!!💩💩💩") do |menu|
          menu.choice "Create a new playlist"  => -> do  create_playlist end
          menu.choice "⏪ Back" => -> do  tty_menus end
          end
       end
    arr=  userr.playlists.map{|playlist|  playlist.name}
      tty_displaying_playlists(arr)
    end


    def tty_displaying_playlists(arr)
      system 'clear'
      prompt = TTY::Prompt.new
      prompt.select("All playlists") do |menu|
        arr.each do |el|
        menu.choice "#{el}" => -> do  show_music_from_playlist(el) end
        end

        menu.choice "⏪Go back" => -> do  tty_menus end
      end
    end



    def show_music_from_playlist(playlist_name)
      userr=User.find_by(id:$user)
      play=userr.playlists.select{|playlist| playlist.name == playlist_name}[0]
      arr=play.musics.map{|music| music.title}
      tty_displaying_musics(arr)
    end


    def tty_displaying_musics(arr)
      system 'clear'
      begin
      prompt = TTY::Prompt.new
      prompt.select("All Musics") do |menu|
        arr.each do |el|
        menu.choice "#{el}" => -> do  play_now_music(el) end
        end
         puts "Your playlist is empty" if arr.length ==0
        menu.choice "⏪GO Back" => -> do  display_all_playlists end
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
    abort "See ya later👋✋🏼✌🏽"

    end



# create_playlist
