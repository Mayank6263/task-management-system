class AddPolymorphicUuidColumns < ActiveRecord::Migration[8.0]
  def change
    add_column :comments, :commentable_uuid, :uuid, default: "gen_random_uuid()"
    add_index :comments, [:commentable_uuid, :commentable_type], unique:true
    add_column :likes, :likeable_uuid, :uuid

        
    remove_column :likes, :likeable_id, :bigint
    remove_column :comments, :commentable_id, :bigint
  end
end
