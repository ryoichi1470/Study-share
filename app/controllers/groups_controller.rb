class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search].present?
      @groups = Group.where('name ILIKE ? OR theme ILIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @groups = Group.all
    end
  end

  def show
    @pending_memberships = @group.group_memberships.pending if current_user == @group.creator
    @approved_memberships = @group.group_memberships.approved
    @members = @group.group_memberships.approved.includes(:user).map(&:user)
    @membership = @group.group_memberships.find_by(user: current_user)
  end


  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.creator = current_user 
  
    if @group.save
      @group.group_memberships.create(user: current_user, status: :approved)
      redirect_to @group, notice: 'グループが作成されました。'
    else
      render :new
    end
  end

  def destroy
    if current_user.admin? || @group.creator == current_user
      @group.destroy
      redirect_to groups_path, notice: 'グループが削除されました。'
    else
      redirect_to groups_path, alert: '削除権限がありません。'
    end
  end
  
  def apply_to_group
    group = Group.find(params[:id])
    membership = group.group_memberships.new(user: current_user, status: :pending)
    
    if membership.save
      flash[:notice] = "参加申請が送信されました。グループ作成者の承認をお待ちください。"
    else
      flash[:alert] = "参加申請に失敗しました。"
    end
    redirect_to group_path(group)
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :theme, :rules)
  end
end
