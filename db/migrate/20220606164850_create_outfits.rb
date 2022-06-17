class CreateOutfits < ActiveRecord::Migration[5.2]
  def change
    create_table :outfits do |t|
      t.string :name, null: false
      t.string :description
      t.boolean :always,  null: false
      t.boolean :spring,  null: false
      t.boolean :summer,  null: false
      t.boolean :autum,  null: false
      t.boolean :winter,  null: false
      t.string :major_color,  null: false
      t.string :sub_color, null: false
      t.string :tone, null: false
      t.boolean :volumey_flg
      t.datetime :purchase_data
      t.string :image
      t.references :category, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
