class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authorize_user!, only: [:edit]
  
  def destroy
    super do
      redirect_to new_user_registration_path and return
    end
  end
  
  def edit
    @user = current_user
    super
  end
  
  def after_update_path_for(resource)
    mypage_path
  end
  
  private

  def authorize_user!
    @user = User.find(params[:format])
    unless @user == current_user
      redirect_back(fallback_location: mypage_path)
    end
  end
end
