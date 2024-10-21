class GroupMembershipsController < ApplicationController
  before_action :set_group
  before_action :set_membership, only: [:destroy, :update]  

  def create
    @membership = @group.group_memberships.new(user: current_user, status: :pending)
    if @membership.save
      redirect_to @group, notice: '参加申請が送信されました。'
    else
      redirect_to @group, alert: '参加申請に失敗しました。'
    end
  end

  def destroy
    @membership = @group.group_memberships.find_by(user: current_user)
  
    if @membership.present?
      @membership.destroy
      redirect_to groups_path, notice: 'グループを退会しました。'
    else
      redirect_to @group, alert: '退会に失敗しました。'
    end
  end
  
  def update
    if params[:status] == 'rejected'
      if @membership.destroy
        flash[:alert] = '申請は拒否されました。再度申請が可能です。'
        respond_to do |format|
          format.html { redirect_to @group, notice: '申請は拒否されました。再度申請が可能です。' }
          format.js
        end
      else
        respond_to do |format|
          format.html { redirect_to @group, alert: '申請の拒否に失敗しました。' }
          format.js
        end
      end
    elsif @membership.update(status: params[:status])
      respond_to do |format|
        format.html { redirect_to @group, notice: 'ステータスが更新されました。' }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to @group, alert: 'ステータスの更新に失敗しました。' }
        format.js
      end
    end
  end


  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_membership
    @membership = @group.group_memberships.find_by(id: params[:id])
    if @membership.nil?
      redirect_to @group, alert: '参加申請が見つかりません。'
    end
  end
end
