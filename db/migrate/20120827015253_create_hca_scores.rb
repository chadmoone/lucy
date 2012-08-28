class CreateHcaScores < ActiveRecord::Migration
  def change
    create_table :hca_scores do |t|
      t.references :diamond
      t.decimal :score
      t.string :light_return
      t.string :fire
      t.string :scintillation
      t.string :spread

      t.timestamps
    end
    
    remove_column :diamonds, :hca_score
  end
end
