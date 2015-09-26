class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.references :exposition, index: true, foreign_key: true
      t.references :ambassador, index: true, foreign_key: true
      t.boolean :choice, default: nil # nil (unchosen) true (home) or false (away)

      t.timestamps null: false
    end
  end
end
