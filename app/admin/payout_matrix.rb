ActiveAdmin.register PayoutMatrix do
  menu priority: 2

  permit_params :generation, :amount

  index do
    selectable_column
    id_column
    column :generation
    column :amount
    actions
  end

  filter :generation
  filter :amount
  filter :created_at

  form do |f|
    f.inputs "Payout Details" do
      f.input :generation
      f.input :amount
    end
    f.actions
  end

end
