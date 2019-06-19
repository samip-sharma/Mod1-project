class CreatePlaylistmusics < ActiveRecord::Migration[5.2]
  def change
    create_table :playlistmusics do |t|
      t.integer :playlist_id
      t.integer :music_id
    end
  end
end
