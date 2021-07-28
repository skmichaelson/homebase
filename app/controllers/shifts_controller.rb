class ShiftsController < ApplicationController
  def index
    everyone = Employee.all
    if params['sort_by'] == 'first_name'
      everyone = Employee.all.sort_by(&:first_name)
    elsif params['sort_by'] == 'last_name'
      everyone = Employee.all.sort_by(&:last_name)
    end

    employees = everyone.map do |employee|
      {
        name: employee.display_name,
        shifts: employee.shifts.map(&:payload_properties),
      }
    end

    render json: employees
  end
end
