class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.boolean :liked, default: :false
      t.references :likeable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
