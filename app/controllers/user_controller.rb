class UserController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    user = User.where(email: params[:email]).first
    if user.nil?
      params =  user_params
      params['password'] = 'empty' if params['password'].nil?
      user = User.create!(params)
    end
    render json: {status: 'success', user_id: user.id, name: user.first_name}, status: 200
  rescue StandardError => e
    error_response(e.message)
  end

  def show
    user = get_param_user
    if user
      return_user user
    else
      return_error('MISSING_USER') unless params[:email]
    end
  end

  def destroy
    message = 'NO_USER_MATCHES'
    user = get_param_user
    unless user.nil?
      user.destroy
      message = 'USER_DELETED'
    end
    render json: {status: 'success', message: message}, status: 200
  end

  def login
    user =  User.find_by(email: params[:email]).try(:authenticate, params[:password])
    if user
      return_user user
    else
      return_error 'Invalid email or password'
    end
  end

  # Search for users
  def index
    name = params['name'] ? params['name'].downcase : ''
    user_id = params["user_id"] ? params["user_id"] : 0
    users = User
              .where(
                "(lower(first_name) LIKE (?) OR lower(second_name) LIKE (?) OR lower(last_name) LIKE (?)) and id != (?) ",
                       "%#{name}%", "%#{name}%", "%#{name}%", "#{user_id}")
              .order({ id: :desc })
              .limit(20)


    render json: {status: 'success', message: "Returning users", data: users}, status: 200
  end

  private
    def user_params
      params.permit(
        :user_id,
        :user_name,
        :first_name,
        :second_name,
        :last_name,
        :contact_number,
        :building_name,
        :address_line_1,
        :address_line_2,
        :city,
        :country,
        :postcode,
        :email,
        :password,
        :password_confirmation
      )
  end
end
