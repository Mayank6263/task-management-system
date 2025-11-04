class AddPolymorphicUuidColumns < ActiveRecord::Migration[8.0]
  def change
    add_column :comments, :commentable_uuid, :uuid
    add_column :likes, :likeable_uuid, :uuid
  end
end
