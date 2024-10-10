class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authorize_user!, only: [:edit]
  
  def destroy
    super do
      redirect_to new_user_registration_path and return
    end
  end
  
  def edit
    super
  end
  
  def after_update_path_for(resource)
    mypage_path(resource)  
  end
  
  private

  def authorize_user!
    if current_user.nil? || (params[:id].to_i != current_user.id)
      redirect_to mypage_path, alert: "このページにはアクセスできません。"
    end
  end
end


