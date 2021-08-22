class User < ApplicationRecord
  devise :registerable, :confirmable,
         :recoverable, :rememberable, :validatable,
         :two_factor_authenticatable,
         otp_secret_encryption_key: ENV['OTP_KEY']

  # Token for autologin from link in notification email
  has_secure_token
  belongs_to :department

  # Requests made by user
  has_many :made_requests, class_name: 'ServiceRequest', foreign_key: 'user_id', dependent: :destroy

  # Requests assignes to the technician
  has_many :service_request_technicians
  has_many :assigned_requests, through: :service_request_technicians, source: :service_request

  before_create :default_values
  def default_values
    # Possible to change default value of 2fa requirement
    self.otp_required_for_login = false
  end

  # Overwrite devise method for background job
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  # generate qr code for 2fa
  def otp_qr_code
    issuer = 'HelpDesk'
    label = "#{issuer}:#{email}"
    qrcode = RQRCode::QRCode.new(otp_provisioning_uri(label,issuer: issuer))
    qrcode.as_svg(module_size: 3)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def technician?
    department.technicians?
  end

  def self.technicians
    joins(:department).where(department: { technicians?: true })
  end
end
