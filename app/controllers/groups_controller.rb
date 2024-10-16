class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search].present?
      @groups = Group.where('name LIKE ? OR theme LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @groups = Group.all
    end
  end

  def show
    @pending_memberships = @group.group_memberships.pending if current_user == @group.creator
    @members = @group.members 
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)
    if @group.save
      redirect_to group_path(@group), notice: 'グループが作成されました。' 
    else
      render :new
    end
  end

  def destroy
    if current_user.admin? || @group.user == current_user
      @group.destroy
      redirect_to groups_path, notice: 'グループが削除されました。'
    else
      redirect_to groups_path, alert: '削除権限がありません。'
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :theme, :rules)
  end
end
