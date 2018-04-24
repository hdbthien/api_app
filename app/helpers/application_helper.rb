module ApplicationHelper
  def api_response messages, code
    render json: {messages: [messages]}, status: code
  end
end
