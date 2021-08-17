class CreateServiceRequestTechnicians < ActiveRecord::Migration[6.1]
  def change
    create_table :service_request_technicians do |t|
      t.references :service_request, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
