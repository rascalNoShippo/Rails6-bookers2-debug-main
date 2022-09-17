class RelationshipsController < ApplicationController

  def create
    follow = Relationship.new
    follow.following_id = current_user.id
    follow.follower_id = params[:user_id]
    follow.save
    redirect_back(fallback_location: users_path)
  end

  def destroy
    follow = Relationship.find_by(following_id: current_user.id, follower_id: params[:user_id])
    follow.destroy
    redirect_back(fallback_location: users_path)
  end

  def following
    #followed_users = Relationship.where(follower_id: params[:user_id]).to_a
    @users = User.find(params[:user_id]).following_users

  end

  def followers
    #following_users = Relationship.where(following_id: params[:user_id])
    #User.find_by(following_users.following_id)
    @users = User.find(params[:user_id]).followed_users
  end

end
