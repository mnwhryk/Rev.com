class CreateTagMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_maps do |t|
      t.references :comic, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
      t.index [:comic_id, :tag_id], unique: true
    end
  end
end
