class RegistrationsController < ApplicationController
  allow_unauthenticated_access
  require "googleauth"
  require "googleauth/stores/redis_token_store"
  require "google/apis/oauth2_v2"
  require "securerandom"

  def new
    redirect_to home_path if authenticated?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to session_path
    else
      flash[:alert] = @user.errors.full_messages.join("\n")
      render :new
    end
  end

  def google
    client_id = Google::Auth::ClientId.from_file('client_secret_500209858623-g747vbhpg4vsdnqjjffu2h28i3nql44a.apps.googleusercontent.com.json')
    scope = ['https://www.googleapis.com/auth/userinfo.profile']
    token_store = Google::Auth::Stores::RedisTokenStore.new(redis: "redis://localhost:6379")
    authorizer = Google::Auth::WebUserAuthorizer.new(
      client_id, scope, token_store, '/google_success')
    auth_uri = authorizer.get_authorization_url(request: request)
    redirect_to(auth_uri, allow_other_host: true)
  end

  def google_success
    client_id = Google::Auth::ClientId.from_file('client_secret_500209858623-g747vbhpg4vsdnqjjffu2h28i3nql44a.apps.googleusercontent.com.json')
    scope = ['https://www.googleapis.com/auth/userinfo.profile']
    token_store = Google::Auth::Stores::RedisTokenStore.new(redis: "redis://localhost:6379")
    authorizer = Google::Auth::WebUserAuthorizer.new(
      client_id, scope, token_store, '/google_success')
    client = authorizer.get_credentials_from_code(code: params[:code], base_url: "http://localhost:3000/google_success")

    oauth2_client = Google::Apis::Oauth2V2::Oauth2Service.new
    oauth2_client.authorization = client
    user_info = oauth2_client.get_userinfo

    if User.where(email_address: user_info.email).exists?
      user = User.find_by(email_address: user_info.email)
      session[:user_id] = user.id
      start_new_session_for user
      redirect_to session_path
    else
      user = User.new(email_address: user_info.email, firstname: user_info.given_name, lastname: user_info.family_name, password: SecureRandom.alphanumeric(24))
      user.save
      start_new_session_for user
      redirect_to session_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :firstname, :lastname, :password, :password_confirmation)
  end
end
