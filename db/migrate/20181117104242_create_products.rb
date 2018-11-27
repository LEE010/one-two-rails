class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :price, null: false
      t.string :image
      t.text :info
      t.belongs_to :store, foreign_key: true

      t.timestamps
    end
  end
end
