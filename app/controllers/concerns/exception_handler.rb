module ExceptionHandler
  extend ActiveSupport::Concern

  include ApplicationHelper

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :unprocessable_entity
    rescue_from ExceptionHandler::InvalidToken, with: :unprocessable_entity

    rescue_from ActiveRecord::RecordNotFound do |e|
      api_response({message: e.message}, :not_found)
    end
  end

  private

  def unprocessable_entity e
    api_response({message: e.message}, :unprocessable_entity)
  end

  def unauthorized_request e
    api_response({message: e.message}, :unauthorized)
  end
end
