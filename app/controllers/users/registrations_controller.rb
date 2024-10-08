class Users::RegistrationsController < Devise::RegistrationsController
  
  def destroy
    super do
      redirect_to new_user_registration_path and return
    end
  end
end


