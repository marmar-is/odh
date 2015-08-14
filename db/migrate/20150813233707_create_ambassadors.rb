class CreateAmbassadors < ActiveRecord::Migration
  def change
    create_table :ambassadors do |t|
      t.string :token
      t.integer :role
      t.integer :parent_id, foreign_key: true

      t.timestamps null: false
    end

    add_index :ambassadors, :token, unique: true
    add_index :ambassadors, :parent_id
    #add_reference :ambassadors, :ambassador, index: true, foreign_key: true, name: 'parent_id'
  end
end
