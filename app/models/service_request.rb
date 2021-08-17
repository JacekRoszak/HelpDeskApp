class ServiceRequest < ApplicationRecord
  belongs_to :request_status
  belongs_to :user
  belongs_to :location
  belongs_to :department

  validates :name, presence: true

  after_create_commit  { broadcast_prepend_to 'service_requests' }
  after_update_commit  { broadcast_replace_to 'service_requests' }
  after_destroy_commit { broadcast_remove_to 'service_requests'  }

  def owner
    user.full_name
  end

  def status
    request_status.name
  end
end
