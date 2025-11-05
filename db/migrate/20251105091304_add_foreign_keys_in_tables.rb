class AddForeignKeysInTables < ActiveRecord::Migration[8.0]
  TABLES = [:posts, :comments, :likes]
  def up
      execute <<~SQL
      ALTER TABLE posts ADD FOREIGN KEY(user_uuid) REFERENCES users(uuid);
      ALTER TABLE comments ADD FOREIGN KEY(user_uuid) REFERENCES users(uuid);
      ALTER TABLE likes ADD FOREIGN KEY(user_uuid) REFERENCES users(uuid);

      SQL
  end
  def down
      execute <<~SQL
      ALTER TABLE posts DROP CONSTRAINT  posts_user_uuid_fkey;
      ALTER TABLE comments DROP CONSTRAINT  comments_user_uuid_fkey;
      ALTER TABLE likes DROP CONSTRAINT  likes_user_uuid_fkey;
      SQL
  end
end
