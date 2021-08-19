class ServiceRequest < ApplicationRecord
  belongs_to :request_status
  belongs_to :user
  belongs_to :location
  belongs_to :department

  has_many :service_request_technicians
  has_many :technicians, through: :service_request_technicians, source: :user, dependent: :destroy

  validates :name, presence: true

  after_create_commit  { broadcast_prepend_to 'service_requests' }
  after_update_commit  { broadcast_replace_to 'service_requests' }
  after_destroy_commit { broadcast_remove_to 'service_requests'  }

  default_scope -> { order('request_status_id', 'service_requests.updated_at desc').where.not('request_status_id IN (5,6) AND service_requests.updated_at < ?', 2.days.ago) }
  def owner
    user.full_name
  end

  def status
    request_status.name
  end

  def color
    case request_status.id
    when RequestStatus.first.id
      'badge bg-warning text-dark'
    when RequestStatus.all[1].id
      'badge bg-info text-dark'
    when RequestStatus.all[2].id
      'badge bg-primary'
    when RequestStatus.all[3].id
      'badge bg-secondary'
    when RequestStatus.all[4].id
      'badge bg-success'
    else
      'badge bg-danger'
    end
  end

  def background
    if important?
      '#d9534f'
    else
      case request_status.id
      when RequestStatus.first.id
        '#18181A'
      when RequestStatus.all[1].id
        '#18181A'
      when RequestStatus.all[2].id
        '#18181A'
      when RequestStatus.all[3].id
        '#18181A'
      when RequestStatus.all[4].id
        ''
      else
        ''
      end
    end
  end
  

  def check_taken_status
    if request_status.id == RequestStatus.all[0].id
      update(request_status_id: RequestStatus.all[1].id)
    end
  end

  def technicians_initials
    initials = ''
    technicians.each { |t| initials+= "#{t.first_name[0]}.#{t.last_name[0]}. " }
    initials += ''
    initials
  end
  
end
