class CreateAjaScores < ActiveRecord::Migration
  def change
    create_table :aja_scores do |t|
      t.references :diamond
      t.string :tab_percent
      t.string :crown_angle
      t.string :crown_height
      t.string :pavilion_depth
      t.string :girdle
      t.string :depth
      t.string :polish
      t.string :symmetry
      t.string :total_grade

      t.timestamps
    end
    add_index :aja_scores, :diamond_id
    
    # remove_column :diamonds, :aja_naja_grade
  end
end
