class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :guest_signed_in?
  before_action :restrict_guest_access, except: [:destroy]

  def after_sign_in_path_for(resource)
    mypage_path
  end
  
  def after_sign_out_path_for(resource)
    about_path
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
  private

  def restrict_guest_access
    if current_user&.guest? && !request.path.match?(users_posts_path)
      flash[:alert] = "ゲストユーザーは投稿一覧以外のページにアクセスできません"
      redirect_to users_posts_path
    end
  end
end
