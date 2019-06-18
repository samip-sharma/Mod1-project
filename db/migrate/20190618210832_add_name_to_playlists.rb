class AddNameToPlaylists < ActiveRecord::Migration[5.2]
  def change
    add_column :playlists, :name, :string
  end
end
