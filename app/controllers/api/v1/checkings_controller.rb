module Api::V1
  class CheckingsController < ApiController
    before_action :set_employee
    before_action :set_checking, only: [:destroy]

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

    def create
      @checking = Checking.new(params_checking)
      if @checking.save
        render json: @checking, status: :created, location: api_v1_employee_checkings_path(@checking)
      else    
        render json: @checking.errors, status: :unprocessable_entity
      end
    end


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