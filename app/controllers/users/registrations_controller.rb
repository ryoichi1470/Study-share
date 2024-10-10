class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user! 
  before_action :correct_user, only: [:edit, :update] 

  # ユーザーアカウント削除時に新規登録ページにリダイレクト
  def destroy
    super do
      redirect_to new_user_registration_path and return
    end
  end

  # 編集画面表示時に、常にcurrent_userを対象とする
  def edit
    @user = current_user
    super()  # 親クラスのeditメソッドを呼び出す
  end

  # 更新後にマイページにリダイレクト
  def after_update_path_for(resource)
    mypage_path
  end

  private

  # 正しいユーザーかどうか確認する
  def correct_user
    unless current_user.id == params[:id].to_i
      redirect_to mypage_path(current_user)
    end
  end
end
