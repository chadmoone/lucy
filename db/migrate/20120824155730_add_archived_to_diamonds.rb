class AddArchivedToDiamonds < ActiveRecord::Migration
  def change
    add_column :diamonds, :archived, :boolean, :default => false
  end
end
