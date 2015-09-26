class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.integer :number
      t.datetime :deadline

      t.timestamps null: false
    end
  end
end
