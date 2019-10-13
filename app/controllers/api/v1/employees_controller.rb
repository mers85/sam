module Api::V1
  class EmployeesController < ApiController
    before_action :authenticate_admin
    def index
      @employees = User.where(admin: false, employee: true)
    end
  end
end