module Api::V1
  class SessionsController < ApiController
    before_action :validate_request

    def_param_group :session do
      param :email, String, desc: 'User email'
      param :password, String, desc: 'User password'
      param :auth_token, String, desc: 'User auth token'
    end

    api :POST, '/api/v1/sessions', 'Longin'
    param :email, String, desc: 'User email', required: true
    param :password, String, desc: 'User password', required: true
    returns :session, code: 200, desc: 'User Signed In'
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