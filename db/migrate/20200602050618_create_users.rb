class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: faulse, unique: true
      t.string :password_digest, null: faulse

      t.timestamps
    end
  end
end
