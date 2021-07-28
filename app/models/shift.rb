class Shift < ApplicationRecord
  belongs_to :employee

  def payload_properties
    {
      day: day,
      start_at: start_at,
      end_at: end_at,
      duration: duration.to_i,
      role: role,
      color: color,
    }
  end
end
