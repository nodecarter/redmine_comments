class AddCommentsCountToIssues < ActiveRecord::Migration
  def self.up
    add_column :issues, :comments_count, :integer, :default => 0, :null => false
  end
  def self.down
    remove_column :issues, :comments_count
  end
end
