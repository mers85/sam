module Api::V1
  class EmployeesController < ApiController
    def index
      @employees = User.where(admin: false, employee: true)
    end
  end
end