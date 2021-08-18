class ServiceRequest < ApplicationRecord
  belongs_to :request_status
  belongs_to :user
  belongs_to :location
  belongs_to :department

  has_many :service_request_technicians
  has_many :technicians, through: :service_request_technicians, source: :user

  validates :name, presence: true

  after_create_commit  { broadcast_prepend_to 'service_requests' }
  after_update_commit  { broadcast_replace_to 'service_requests' }
  after_destroy_commit { broadcast_remove_to 'service_requests'  }

  default_scope -> { order('request_status_id', 'service_requests.updated_at desc') }
  # .where.not('request_status_id IN (5,6) AND service_requests.updated_at < ?', 2.days.ago)

  def owner
    user.full_name
  end

  def status
    request_status.name
  end

  def colors
    "color: #{request_status.color};background-color:#{request_status.background};"
  end
end
