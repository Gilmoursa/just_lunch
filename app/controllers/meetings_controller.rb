class MeetingsController < ApplicationController
  def index
    # binding.pry
    # @meetings = Meeting.where(user_id: params[:user_id])
    # @meetings = User.find(params[:user_id]).meetings
    # Meeting.joins(guests: [{invitations: :user}]).where(user_id: params[:user_id])
    # @meetings = Meeting.select('meetings.*').joins(guests: {invitation: :user}).group('id').where(user_id = params[:id])
    @user = User.find(params[:user_id])
    meetings = @user.meetings
    @meetings = meetings.sort_by{|meeting| meeting.created_at}.reverse
  end

  def show
     @user = User.find(params[:user_id])
     @meeting = Meeting.find(params[:id])
     @restaurant = Meeting.find(params[:id]).restaurant
  end

  def edit
    user = User.find(params[:user_id])
    @guest = user.guests.select do |guest| 
      params[:id].to_i == guest.meeting_id
    end.first
  end
end