class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.string :option1
      t.string :option2
      t.string :stock, null: false
      t.string :code
      t.belongs_to :product, foreign_key: true

      t.timestamps

      t.timestamps
    end
  end
end
