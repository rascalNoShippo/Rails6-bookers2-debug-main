class ParticipationsController < ApplicationController
  def create
    Group.find(params[:group_id]).participations.new(user_id: current_user.id).save
    redirect_to group_path(params[:group_id])
  end
  def destroy
    Participation.find_by(group_id: params[:group_id], user_id: current_user.id).destroy
    redirect_to group_path(params[:group_id])
  end
  
end
