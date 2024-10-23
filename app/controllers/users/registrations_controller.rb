class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authorize_user!, only: [:edit, :update, :destroy] 
  # before_action :correct_user, only: [:edit, :update] 

  def destroy
    super do
      redirect_to new_user_registration_path and return
    end
  end
  


  # def edit
  #   @user = current_user
  # rescue ActiveRecord::RecordNotFound
  #   redirect_to root_path, alert: "ユーザーが見つかりません。"
  # end

  
  # def update
  #   @user = current_user 
  
  #   if @user.update(user_params)
  #     redirect_to mypage_path(@user), notice: 'ユーザー情報が更新されました。'
  #   else
  #     flash.now[:alert] = @user.errors.full_messages.to_sentence
  #     render :edit 
  #   end
  # end


  def after_update_path_for(resource)
    mypage_path
  end

   private
    def authorize_user!
      user_id = params[:format] || current_user.id
      @user = User.find(user_id)
      unless @user == current_user
        redirect_back(fallback_location: mypage_path, alert: "権限がないため、この操作を実行できません。")
      end
    end

  
  # def correct_user
  #   Rails.logger.debug "Params: #{params.inspect}"
  #   if current_user.nil?
  #     redirect_to root_path, alert: "ログインが必要です。"
  #   elsif current_user.id != params[:id].to_i
  #     redirect_to root_path
  #   end
  # end


  
  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end
