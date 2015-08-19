class AddStripeAccountToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :stripe_account_id, :string
    add_index :accounts, :stripe_account_id

    #add_column :accounts, :stripe_subscription_id, :string
    #add_index :accounts, :stripe_subscription_id
  end
end
