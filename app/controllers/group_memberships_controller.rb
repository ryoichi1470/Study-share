class GroupMembershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    group = Group.find(params[:group_id])
    membership = group.group_memberships.new(user: current_user)

    if membership.save
      redirect_to group_path(group), notice: '参加申請を送信しました。'
    else
      redirect_to group_path(group), alert: '参加申請に失敗しました。'
    end
  end

  def update
    membership = GroupMembership.find(params[:id])
    if membership.update(status: params[:status])
      redirect_to group_path(membership.group), notice: '申請ステータスが更新されました。'
    else
      redirect_to group_path(membership.group), alert: 'ステータスの更新に失敗しました。'
    end
  end
end
