class BackfillUuids < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!  # allows long updates

  def up
    say_with_time "Backfilling UUID foreign keys" do
      # Users → Posts
      execute <<~SQL
        UPDATE posts
        SET user_uuid = users.uuid
        FROM users
        WHERE posts.user_id = users.id;
      SQL

      # Users → Comments
      execute <<~SQL
        UPDATE comments
        SET user_uuid = users.uuid
        FROM users
        WHERE comments.user_id = users.id;
      SQL

      # Users → Likes
      execute <<~SQL
        UPDATE likes
        SET user_uuid = users.uuid
        FROM users
        WHERE likes.user_id = users.id;
      SQL
    end

    def down
      say_with_time "Clearing backfilled UUIDs" do
        execute "UPDATE posts SET user_uuid = NULL;"
        execute "UPDATE comments SET user_uuid = NULL;"
        execute "UPDATE likes SET user_uuid = NULL;"
      end
    end

  end
end
