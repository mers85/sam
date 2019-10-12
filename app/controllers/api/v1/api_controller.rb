module Api::V1
  class ApiController < ApplicationController
    # To allow only json request
    protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }
  
  end
end