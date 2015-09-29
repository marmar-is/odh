ActiveAdmin.register AdminUser do
  menu priority: 3, if: proc{ !current_admin_user.delegate? }

  controller do
    # Restrict abilities of basic admin
    def action_methods
      if current_admin_user && current_admin_user.admin?
        super
      else
        super - ['index', 'new', 'create', 'edit', 'update', 'destroy', ]
      end
    end

    def update
      if params[:admin_user][:password].blank?
        params[:admin_user].delete("password")
        params[:admin_user].delete("password_confirmation")
      end

      super
    end
  end

  permit_params :email, :role, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :role
    column :current_sign_in_at
    #column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :role
  filter :current_sign_in_at
  #filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :role, as: :select, collection: AdminUser.roles.keys, include_blank: false
      #f.input :role
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
