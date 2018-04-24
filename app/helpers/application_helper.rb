module ApplicationHelper
  def api_response messages, code = :ok
    render json: {messages: [messages]}, status: code
  end
end
