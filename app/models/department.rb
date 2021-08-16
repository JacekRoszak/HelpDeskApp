class Department < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  def self.technicians
    where(technicians?: true)    
  end
  
end
