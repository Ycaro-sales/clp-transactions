class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base. to_s

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end

class ApplicationController < ActionController::API
  def not_found
    render json: { error: "not_found" }
  end

  def authorize_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find_or_create_by(id: @decoded[:user_id]) do |user|
        user.email = params[:email]
        user.cpf = params[:cpf]
        user.name = params[:name]
        user.account_id = params[:account_id]
      end
    rescue JWT::DecodeError => e.errors
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
