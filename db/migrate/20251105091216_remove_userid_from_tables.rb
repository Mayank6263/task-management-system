class RemoveUseridFromTables < ActiveRecord::Migration[8.0]
  TABLES = [:posts, :comments, :likes]
  def change
    TABLES.each do |table|
      remove_column table, :user_id, :bigint
    end
  end
end
