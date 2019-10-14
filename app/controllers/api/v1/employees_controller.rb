module Api::V1
  class EmployeesController < ApiController
    before_action :authenticate_admin

    def_param_group :employee do
      param :id, Integer
      param :email, String
      param :first_name, String
      param :last_name, String
    end
    api :GET, '/api/v1/employees', 'Shows all employees'
    param_group :employee, code: 200, desc: 'All employees'
    def index
      @employees = User.where(admin: false, employee: true)
    end
  end
end