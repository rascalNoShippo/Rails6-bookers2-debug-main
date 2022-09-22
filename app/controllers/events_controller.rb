class EventsController < ApplicationController
  def new
    @event = {:group_id => "", :title => "", :detail => ""}
  end

  def create
    @event = {:group_id => params[:group_id], :title => params[:title], :detail => params[:detail]}
    members = Group.find(params[:group_id]).members
    members.each do |user|
      SendMailMailer.soushin(user, @event).deliver_now
    end
    @sent = true
    render "groups/show"
  end
end
