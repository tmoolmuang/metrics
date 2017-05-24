class AppsController < ApplicationController
  def index
    @apps = App.all
  end

  def show
    @app = App.find(params[:id])
  end

  def new
    @app = App.new
  end  
  
  def create
    @app = App.new
    @app.name = params[:app][:name]
    @app.url = params[:app][:url]
    @app.user_id = params[:app][:user_id]

    if @app.save
      redirect_to @app, notice: "Application was registered successfully."
    else
      flash.now[:alert] = error_messages(@app)
      render :new
    end
  end
  
  def edit
    @app = App.find(params[:id])
  end
  
  def update
    @app = App.find(params[:id])
    @app.name = params[:app][:name]
    @app.url = params[:app][:url]
    
    if @app.save
      redirect_to @app, notice: "Application was updated successfully."
    else
      flash.now[:alert] = error_messages(@app)
      render :edit
    end
  end
  
  def destroy
    @app = App.find(params[:id])
    
    if @app.destroy
      flash[:notice] = "\"#{@app.name}\" was deleted successfully."
      redirect_to myapps_apps_path
    else
      flash.now[:alert] = "There was an error deleting the application."
      render :show
    end
  end
  
  def myapps
    @apps = App.where(user_id: current_user.id).order('created_at desc')
  end
  
  def demoapps
    @apps = App.where(user_id: 1).order('created_at desc')
    # assuming db is seeded with admin
  end
  
end
