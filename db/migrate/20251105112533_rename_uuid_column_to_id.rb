class RenameUuidColumnToId < ActiveRecord::Migration[8.0]
  TABLES = [:users, :posts, :comments, :likes]
  def change
    TABLES.each do |table|
      rename_column table, :uuid, :id
    end
  end
end
