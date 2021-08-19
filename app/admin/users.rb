ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :first_name, :last_name, :cell_number, :work_number, :inner_number, :admin?, :department_id

  index do
    selectable_column
    column :full_name
    column :email
    column :admin?
    actions
  end

  filter :email
  filter :full_name

  show do
    attributes_table do
      row :full_name
      row :email
      row :created_at
      row :update_at
      row :last_sign_in_at
    end
    active_admin_comments
  end

  form do |f|
    f.semantic_errors
    f.object.errors.keys
    f.input :first_name
    f.input :last_name
    f.input :email
    f.input :department
    f.input :admin?
    f.input :password
    f.input :password_confirmation
    actions
  end

  controller do
    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete('password')
        params[:user].delete('password_confirmation')
      end
      super
    end
  end
end
