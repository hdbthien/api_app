module ApplicationHelper
  def api_response object, code = :ok
    render json: object, status: code
  end
end
