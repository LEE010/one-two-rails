class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :mobile
      t.string :postcode
      t.string :address
      t.string :address2
      t.date :birth
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
