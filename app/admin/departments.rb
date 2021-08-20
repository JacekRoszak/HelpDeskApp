ActiveAdmin.register Department do
  index do
    selectable_column
    column :name
    column :technicians?
    column :updated_at
    actions
  end

  filter :name
  filter :technicians?

  form do |f|
    f.input :name
    f.input :technicians?
    actions
  end

  permit_params :name, :technicians?
end
