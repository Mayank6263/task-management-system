class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.string :firstname
      t.string :lastname
      t.integer :age
      t.integer :gender

      t.timestamps
    end
  end
end
