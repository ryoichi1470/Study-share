class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user! 
  before_action :correct_user, only: [:edit, :update] 

  def destroy
    super do
      redirect_to new_user_registration_path and return
    end
  end

  def edit
    @user = current_user
    super()  
  end

  def after_update_path_for(resource)
    mypage_path
  end

  private

  def correct_user
    unless current_user.id == params[:id].to_i
      redirect_to mypage_path(current_user)
    end
  end
end
