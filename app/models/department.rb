class Department < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :users

  def self.technicians
    where(technicians?: true)
  end
end
