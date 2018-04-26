class Api::UsersController < Api::ApiController
  skip_before_action :authorize_request, only: :create
  before_action :find_user, only: :upgrade_user

  def create
    user = User.create! user_params
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = {message: Message.account_created, auth_token: auth_token}
    api_response response, :created
  end

  def upgrade_user
    if @user.update_attribute(:admin, true)
      api_response({message: Message.upgrade_admin_sucesss}, :ok)
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit :name,
                  :email,
                  :password,
                  :password_confirmation
  end

  def email_params
    params.permit :email
  end

  def find_user
    return if email_params[:email].present? && @user = User.find_by(email: email_params[:email])
    raise ActiveRecord::RecordNotFound, Message.not_found("email")
  end
end
