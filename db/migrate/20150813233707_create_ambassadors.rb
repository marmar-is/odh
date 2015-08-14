class CreateAmbassadors < ActiveRecord::Migration
  def change
    create_table :ambassadors do |t|
      t.string :token
      t.string :registration_token

      t.integer :status
      t.integer :parent_id, foreign_key: true

      t.timestamps null: false
    end

    add_index :ambassadors, :token, unique: true
    add_index :ambassadors, :registration_token, unique: true
    add_index :ambassadors, :parent_id
  end
end
