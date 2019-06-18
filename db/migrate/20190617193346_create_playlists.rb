class CreatePlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :playlists do |t|
      t.integer :user_id, foreign_key :true
      t.integer :music_id, foreign_key :true
    end
  end
end
