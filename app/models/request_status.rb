class RequestStatus < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  def self.closing_statuses
    RequestStatus.last(2).pluck(:id)
  end
end
