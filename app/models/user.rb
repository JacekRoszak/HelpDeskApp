class User < ApplicationRecord
  devise :registerable, :confirmable,
         :recoverable, :rememberable, :validatable,
         :two_factor_authenticatable,
         otp_secret_encryption_key: ENV['OTP_KEY']

  # Token for autologin from link in notification email
  has_secure_token

  before_create :default_values
  def default_values
    self.otp_required_for_login = false
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def otp_qr_code
    issuer = 'HelpDesk'
    label = "#{issuer}:#{email}"
    qrcode = RQRCode::QRCode.new(otp_provisioning_uri(label,issuer: issuer))
    qrcode.as_svg(module_size: 3)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
