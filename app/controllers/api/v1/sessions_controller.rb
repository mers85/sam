module Api::V1
  class SessionsController < ApiController
    before_action :validate_request

    def create
      user = User.find_by_email(params[:email].downcase)

      if user && user.valid_password?(params[:password])
        render json: {
          message: "User Signed In",
          user_id: user.id,
          auth_token: user.api_key
        }
      else
        unauthorized
      end
    end

    private

    def validate_request 
      unless params.key?(:email) && params.key?(:password)
        return bad_request
      end
    end
  end
end