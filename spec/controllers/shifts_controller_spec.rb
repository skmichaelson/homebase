require 'rails_helper'

RSpec.describe ShiftsController do
  let(:alpha_shift_1_properties) do
    {
      'day' => 5,
      'start_at' => "9am",
      'end_at' => "2pm",
      'duration' => 5,
      'role' => "Host",
      'color' => "green",
    }
  end
  let(:alpha_shift_1) { Shift.new(alpha_shift_1_properties) }

  let(:alpha_shift_2_properties) do
    {
      'day' => 1,
      'start_at' => "11am",
      'end_at' => "6pm",
      'duration' => 7,
      'role' => "Chef",
      'color' => "orange"
    }
  end
  let(:alpha_shift_2) { Shift.new(alpha_shift_2_properties) }

  let(:gamma_shift_1_properties) do
    {
      'day' => 1,
      'start_at' => "9am",
      'end_at' => "3pm",
      'duration' => 6,
      'role' => "Dishwasher",
      'color' => "purple"
    }
  end
  let(:gamma_shift_1) { Shift.new(gamma_shift_1_properties) }

  let(:delta_shift_1_properties) do
    {
      'day' => 2,
      'start_at' => "9am",
      'end_at' => "1pm",
      'duration' => 4,
      'role' => "Chef",
      'color' => "orange"
    }
  end
  let(:delta_shift_1) { Shift.new(delta_shift_1_properties) }

  let(:delta_shift_2_properties) do
    {
      'day' => 1,
      'start_at' => "9am",
      'end_at' => "12pm",
      'duration' => 3,
      'role' => "Host",
      'color' => "green",
    }
  end
  let(:delta_shift_2) { Shift.new(delta_shift_2_properties) }

  let!(:employee_alpha) {
    Employee.create(first_name: 'Alpha', last_name: 'Omega', shifts: [alpha_shift_1, alpha_shift_2])
  }
  let!(:employee_gamma) {
    Employee.create(first_name: 'Gamma', last_name: 'Psi', shifts: [gamma_shift_1])
  }
  let!(:employee_delta) {
    Employee.create(first_name: 'Delta', last_name: 'Chi', shifts: [delta_shift_1, delta_shift_2])
  }

  def find_employee_shifts(response, employee)
    response.find { |shifts| shifts['name'] == "#{employee.first_name} #{employee.last_name}" }['shifts']
  end

  describe 'GET index' do
    it 'returns shifts for each employee' do
      get :index

      expect(response).to be_successful
      response_body = JSON.parse(response.body)
      employee_alpha_shifts = find_employee_shifts(response_body, employee_alpha)

      expect(employee_alpha_shifts).to include(alpha_shift_1_properties, alpha_shift_2_properties)

      employee_gamma_shifts = find_employee_shifts(response_body, employee_gamma)
      expect(employee_gamma_shifts).to contain_exactly(gamma_shift_1_properties)

      employee_delta_shifts = find_employee_shifts(response_body, employee_delta)
      expect(employee_delta_shifts).to contain_exactly(delta_shift_1_properties, delta_shift_2_properties)
    end

    describe 'sorting' do
      it 'sorts by first name' do
        get :index, params: { sort_by: 'first_name' }

        expect(response).to be_successful
        response_body = JSON.parse(response.body)
        employee_names = response_body.map { |shifts| shifts['name'] }
        expect(employee_names).to eq(['Alpha Omega', 'Delta Chi', 'Gamma Psi'])
      end

      it 'sorts by last name' do
        get :index, params: { sort_by: 'last_name' }

        expect(response).to be_successful
        response_body = JSON.parse(response.body)
        employee_names = response_body.map { |shifts| shifts['name'] }
        expect(employee_names).to eq(['Delta Chi', 'Alpha Omega', 'Gamma Psi'])
      end
    end
  end
end
