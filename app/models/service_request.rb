class ServiceRequest < ApplicationRecord
  belongs_to :request_status
  belongs_to :user
  belongs_to :location
  belongs_to :department, optional: true

  def owner
    user.full_name
  end

  def status
    request_status.name
  end
end
