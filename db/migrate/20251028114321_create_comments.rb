class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.string :body
      t.references :user, null: false
      t.references :commentable, polymorphic: true, null: false, index: true

      t.timestamps
    end
  end
end
