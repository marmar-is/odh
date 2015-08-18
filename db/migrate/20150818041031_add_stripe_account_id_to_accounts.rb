class AddStripeAccountIdToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :stripe_account_id, :string
    add_index :accounts, :stripe_account_id
  end
end
