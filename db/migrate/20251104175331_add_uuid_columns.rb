class AddUuidColumns < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :comments, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :posts, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :likes, :uuid, :uuid, default: "gen_random_uuid()", null: false

    
    add_column :posts, :user_uuid, :uuid
    add_column :comments, :user_uuid, :uuid
    add_column :likes, :user_uuid, :uuid

  end
end
