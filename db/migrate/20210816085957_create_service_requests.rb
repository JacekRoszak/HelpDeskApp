class CreateServiceRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :service_requests do |t|
      t.text :name
      t.references :request_status, foreign_key: true
      t.references :user, foreign_key: true
      t.references :location, foreign_key: true
      t.datetime :closed_at
      t.boolean :important, default: false
      t.text :raport
      t.references :department, foreign_key: true

      t.timestamps
    end
  end
end
