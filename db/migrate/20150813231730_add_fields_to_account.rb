class AddFieldsToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :fname, :string, default: ""
    add_column :accounts, :lname, :string, default: ""
    add_column :accounts, :phone, :string, default: ""

    # Address
    add_column :accounts, :street, :string, default: ""
    add_column :accounts, :city, :string, default: ""
    add_column :accounts, :state, :string, default: ""
    add_column :accounts, :zip, :string, default: ""

    add_column :accounts, :dob, :date
  end
end
