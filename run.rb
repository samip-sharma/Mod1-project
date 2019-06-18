require_relative './config/environment.rb'
require 'tty-prompt'
prompt = TTY::Prompt.new


puts "Welcome !!! To MusicIron"
puts "Here you can play song previews and see lyrics"

user_name=prompt.ask('What is your name?', default: "full name(lowercase)")

# if !User.find_by(name:user_name)
#   new_user=User.create(user_name)
# end

# puts "Enter artist name:"
# artist=gets.chomp
# puts "Enter song name:"
# song_name=gets.chomp



option=prompt.select("Select an option:", %w(create_Playlist search_Song my_Playlist delete_Playlist))





# For TTY
# #To confirm input use yes?:
# answer=prompt.yes?('Do you like Ruby?')
# puts answer
# puts name
# #Asking question with list of options couldn't be easier using select like so:
# option=prompt.select("Choose your destiny?", %w(Scorpion Kano Jax))
# # =>
# Choose your destiny? (Use ↑/↓ arrow keys, press Enter to select)
# ‣ Scorpion
#   Kano
#   Jax
puts option=="create_Playlist"
#
