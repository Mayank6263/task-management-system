class BackfillPolymorphicUuids < ActiveRecord::Migration[8.0]
  def change
    say_with_time "Backfilling polymorphic UUIDs" do
      execute <<~SQL
        UPDATE comments
        SET commentable_uuid = posts.uuid
        FROM posts
        WHERE comments.commentable_type = 'Post'
        AND comments.commentable_id = posts.id;
      SQL

      execute <<~SQL
        UPDATE comments
        SET commentable_uuid = comments_parent.uuid
        FROM comments AS comments_parent
        WHERE comments.commentable_type = 'Comment'
        AND comments.commentable_id = comments_parent.id;
      SQL

      execute <<~SQL
        UPDATE likes
        SET likeable_uuid = posts.uuid
        FROM posts
        WHERE likes.likeable_type = 'Post'
        AND likes.likeable_id = posts.id;
      SQL

      execute <<~SQL
        UPDATE likes
        SET likeable_uuid = comments.uuid
        FROM comments
        WHERE likes.likeable_type = 'Comment'
        AND likes.likeable_id = comments.id;
      SQL
    end
  end
  def down
    execute "UPDATE comments SET commentable_uuid = NULL;"
    execute "UPDATE likes SET likeable_uuid = NULL;"
  end

end
