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

    if app_owner?
      @event = @app.events.new(name: params[:event][:name])
      if @event.save
        flash[:notice] = "Event was created successfully."
        redirect_to [@app, @event]
      else
        flash.now[:alert] = error_messages(@event)
        render :new
      end
    else
      flash[:notice] = "Unauthorized: not an application owner."
      redirect_to @app
    end
  end

  def edit
    @event = Event.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:id])
    
    if event_owner?
      @event.name = params[:event][:name]
      if @event.save
        flash[:notice] = "Event was updated successfully."
        redirect_to [@event.app, @event]
      else
        flash.now[:alert] = error_messages(@event)
        render :edit
      end
    else
      flash[:notice] = "Unauthorized: not an event owner."
      redirect_to @event.app
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    
    if event_owner?
      if @event.destroy
        flash[:notice] = "\"#{@event.name}\" was deleted successfully."
        redirect_to @event.app
      else
        flash.now[:alert] = "There was an error deleting the event."
        render :show
      end
    else
      flash[:notice] = "Unauthorized: not an event owner."
      redirect_to @event.app
    end
  end
  
  private
  def app_owner?
    @app.user.id == current_user.id || current_user.admin?
  end

  def event_owner?
    @event.app.user.id == current_user.id || current_user.admin?
  end
end
