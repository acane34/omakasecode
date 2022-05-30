class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :prefecture
      t.float :lat
      t.float :lon
      t.timestamps
    end
  end
end
