module ApplicationHelper

  def return_error_message(arg)
    render json: {status: 'ERROR', message: arg}
  end

  def return_success_message(arg)
    render json: {status: 'ERROR', message: arg}
  end
end
