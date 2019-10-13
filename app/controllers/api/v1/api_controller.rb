module Api::V1
  class ApiController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods
    # To allow only json request
    protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }


    def bad_request
      render json: {
        message: "Bad request",
      }, status: 400
    end

    def unauthorized
      render json: {
        message: "Unauthorized",
      }, status: 401
    end


    protected

    # Authenticate the user with token based authentication
    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_admin
      render_unauthorized unless authenticate_token && @current_user.admin?
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        @current_user = User.find_by(api_key: token)
      end
    end

    def render_unauthorized(realm = "Application")
      self.headers["WWW-Authenticate"] = %(Token realm="#{realm}")
      render json: 'Bad credentials', status: :unauthorized
    end
  
  end
end