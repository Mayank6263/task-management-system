class ReplacePrimarykeyToTables < ActiveRecord::Migration[8.0]
  TABLES = [:users, :posts, :comments, :likes]
  def change
    TABLES.each do | table |
      remove_column table, :id, :bigint
      execute "ALTER TABLE #{table} ADD PRIMARY KEY (uuid);"
    end
  end
end
