class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    current_user.own_groups.new(group_params).save
    redirect_to groups_path
  end

  def show
    @group = Group.find(params[:id])
    @members = @group.members
  end

  def edit
    @group = Group.find(params[:id])
  end
  
  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
    redirect_to group_path(params[:id])
  end

  def destroy
    Group.find(params[:id]).destroy
    redirect_to groups_path
  end

  private
  def group_params
    params.require(:group).permit(:name, :introduction)
  end

end
