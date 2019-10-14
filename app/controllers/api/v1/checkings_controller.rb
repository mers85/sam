module Api::V1
  class CheckingsController < ApiController
    before_action :set_employee
    before_action :set_checking, only: [:destroy]

    def_param_group :checking do
      param :id, Integer, desc: "Checking id"
      param :user_id, Integer, desc: "Employee id"
      param :check_type, String, desc: "Type of checking in or out"
      param :happend_at, DateTime, desc: "checking time"
      param :created_at, DateTime, desc: "Time the checking was created"
    end

    api :GET, '/api/v1/employees/:employee_id/checkings', 'Shows all checkings of an employee'
    param_group :checking, code: 200, desc: 'All checkings'
    api :GET, '/api/v1/employees/:employee_id/checkings?type[:type]', 'Shows all checkings of an employee by type'
    param :type, String, desc: "Type of checking in or out", required: true
    param_group :checking, code: 200, desc: 'All checkings'
    def index
      if params.key?(:type)
        if params[:type] == "in" 
          @checkings = @employee.checkings.where(check_type: "in")
        elsif params[:type] == "out" 
          @checkings = @employee.checkings.where(check_type: "out")
        end
      else
        @checkings = @employee.checkings
      end
    end

    api :POST, '/api/v1/employees/:employee_id/checkings', 'Create a new checking'
    returns :checking, code: 200, desc: 'Created checking'
    param :user_id, Integer, desc: 'Employee id', required: true
    param :check_type, String, desc: 'Type of checking in or out', required: true
    param :happend_at, DateTime, desc: "checking time", required: true
    def create
      @checking = Checking.new(params_checking)
      if @checking.save
        render json: @checking, status: :created, location: api_v1_employee_checkings_path(@checking)
      else    
        render json: @checking.errors, status: :unprocessable_entity
      end
    end

    api :DELETE, '/api/v1/employees/:employee_id/checkings/:id', 'Deletes the requested checking'
    returns code: 200
    param :id, Integer, desc: 'Id of the checking', required: true
    def destroy
      @checking.destroy  
    end

    private

    def set_employee
      @employee = User.find(params[:employee_id])
    end

    def set_checking
      @checking = Checking.find(params[:id])
    end

    def params_checking
      attrs = params.require(:checking).permit(:happend_at, :check_type)
      attrs[:user_id] = @employee.id

      attrs
    end
    
  end
end