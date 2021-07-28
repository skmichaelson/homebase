class Employee < ApplicationRecord
  has_many :shifts

  def display_name
    "#{first_name} #{last_name}"
  end
end
