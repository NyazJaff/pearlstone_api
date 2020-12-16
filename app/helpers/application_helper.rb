module ApplicationHelper

  def return_error(arg)
    render json: {status: 'error', message: arg}
  end

  def return_success_message(arg)
    render json: {status: 'error', message: arg}
  end

  def return_user(user)
    render json: {status: 'success', user: user}, status: 200
  end

  def error_response(e)
    render json:
             {status: 'ERROR',
              message: e},
           status: :unprocessable_entity
  end
end
