class CreatePayoutMatrices < ActiveRecord::Migration
  def change
    create_table :payout_matrices do |t|
      t.integer :generation
      t.integer :amount

      t.timestamps null: false
    end

    add_index :payout_matrices, :generation, unique: true
  end
end
