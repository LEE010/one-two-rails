class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.string :option1
      t.string :option2
      t.integer :stock, null: false
      # t.integer :input_stock
      # t.integer :total_stock
      t.string :code
      t.belongs_to :product, foreign_key: true

      t.timestamps

      t.timestamps
    end
  end
end
