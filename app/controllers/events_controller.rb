class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
  end

  def new
    @app = App.find(params[:app_id])
    @event = Event.new
  end

  def create
    @app = App.find(params[:app_id])
    @event = Event.new
    @event.name = params[:event][:name]
    @event.app = @app

    if @event.save
      flash[:notice] = "Event was created successfully."
      redirect_to [@app, @event]
    else
      flash.now[:alert] = error_messages(@event)
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:id])
    @event.name = params[:event][:name]
    
    if @event.save
      flash[:notice] = "Event was updated successfully."
      redirect_to [@event.app, @event]
    else
      flash.now[:alert] = error_messages(@event)
      render :edit
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    
    if @event.destroy
      flash[:notice] = "\"#{@event.name}\" was deleted successfully."
      redirect_to @event.app
    else
      flash.now[:alert] = "There was an error deleting the event."
      render :show
    end
  end
end
