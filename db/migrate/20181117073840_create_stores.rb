class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.string :name, null: false
      t.string :regist_number, unique: true, null: false
      t.integer :postcode
      t.string :address
      t.string :address2
      t.string :phone_number
      t.string :account_number, null: false
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
