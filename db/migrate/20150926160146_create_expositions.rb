class CreateExpositions < ActiveRecord::Migration
  def change
    create_table :expositions do |t|
      t.datetime :when
      t.decimal :point_spread
      t.string :stream_url
      t.integer :home_id, index: true, foreign_key: true
      t.integer :away_id, index: true, foreign_key: true
      t.belongs_to :week, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
