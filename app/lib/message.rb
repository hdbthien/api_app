class Message
  class << self
    def not_found record = "record"
      "Sorry, #{record} not found."
    end

    def invalid_credentials
      "Invalid credentials"
    end

    def invalid_token
      "Invalid token"
    end

    def missing_token
      "Missing token"
    end

    def unauthorized
      "Unauthorized request"
    end

    def account_created
      "Account created successfully"
    end

    def account_not_created
      "Account could not be created"
    end

    def expired_token
      "Sorry, your token has expired. Please login to continue."
    end

    def upgrade_admin_sucesss
      "This user has been successfully upgraded"
    end

    def dont_have_permission
      "Sorry, you dont have permission to do that. Please contact admin"
    end
  end
end
