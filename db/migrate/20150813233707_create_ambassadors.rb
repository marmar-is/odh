class CreateAmbassadors < ActiveRecord::Migration
  def change
    create_table :ambassadors do |t|
      t.string :token
      t.integer :role

      t.timestamps null: false
    end

    add_index :ambassadors, :token, unique: true
    add_reference :ambassadors, :ambassador, index: true, foreign_key: true, name: 'parent_id'
  end
end
