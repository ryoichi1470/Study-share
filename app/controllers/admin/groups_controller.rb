class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @groups = Group.all
  end

  def destroy
    @group = Group.find(params[:id])
    if @group.destroy
      redirect_to admin_groups_path, notice: 'グループが削除されました。'
    else
      redirect_to admin_groups_path, alert: 'グループの削除に失敗しました。'
    end
  end

  private

  def authenticate_admin!
    redirect_to root_path, alert: '管理者権限が必要です。' unless current_user.admin?
  end
end
