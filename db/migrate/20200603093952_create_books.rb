class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :image_url
      t.string :name, null: false
      t.integer :price
      t.date :purchase_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
