module UserHelper

  def get_param_user
    User.where(email: params[:email]).or(User.where(id: params[:user_id])).first
  end
end
