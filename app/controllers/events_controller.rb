class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :destroy, :rsvp, :rsvp_no, :update]
  before_filter :authorize, only: [:new, :create, :rsvp, :rsvp_no, :edit, :destroy, :update]

  def new
    @event = Event.new
  end

  def show
  end

  def edit
  end

  def create
    @event           = Event.new(event_params)
    @event[:user_id] = session[:user_id]
    if @event.save
      redirect_to event_path(@event), notice: "Good job, you created an event!"
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  def rsvp
    @events_user = EventsUser.find_or_create_by(@event.id, current_user.id, params[:response])
    redirect_to event_path(@event)
  end

  def rsvp_no
    @events_user = EventsUser.find_by(user_id: current_user.id, event_id: @event.id)
    @events_user.destroy
    redirect_to event_path(@event)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :location, :description, :date)
  end
end
