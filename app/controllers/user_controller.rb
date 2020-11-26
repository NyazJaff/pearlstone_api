class UserController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    user = User.where(email: params[:email]).first
    if user.nil?
      user = User.create(user_params)
    end
    render json: {status: 'SUCCESS', user_id: user.id, name: user.first_name}, status: 200
  end

  def show
    user = get_param_user
    if user.nil?
      return return_error_message('MISSING_USER') unless params[:email]
    end
    render json: {status: 'SUCCESS', user: user}, status: 200
  end

  def destroy
    message = 'NO_USER_MATCHES'
    user = get_param_user
    unless user.nil?
      user.destroy
      message = 'USER_DELETED'
    end
    render json: {status: 'SUCCESS', message: message}, status: 200
  end

  private
    # def email_in_params
    #   return return_error_message('MISSING_EMAIL') unless params[:email]
    # end

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
