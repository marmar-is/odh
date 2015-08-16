class AddFieldsToAmbassador < ActiveRecord::Migration
  def change
    add_column :ambassadors, :referred_via, :string
  end
end
