require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:my_user) { create(:user, confirmed_at: DateTime.now) }
  let(:my_app) { create(:app, user: my_user ) }
  let(:my_event) { create(:event, app: my_app) }

  describe "GET #show" do
    it "returns http success" do
      get :show, app_id: my_app.id, id: my_event.id
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #show view" do
      get :show, app_id: my_app.id, id: my_event.id
      expect(response).to render_template :show
    end

    it "assigns my_post to @post" do
      get :show, app_id: my_app.id, id: my_event.id
      expect(assigns(:event)).to eq(my_event)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, app_id: my_app.id, id: my_event.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    it "increases the number of event by 1" do
      expect{ post :create, app_id: my_app.id, event: {name: "new name"} }.to change(Event,:count).by(1)
    end
 
    it "assigns the new event to @event" do
      post :create, app_id: my_app.id, event: {name: my_event.name}
      event_instance = assigns(:event)
      expect(event_instance.name).to eq(my_event.name)
    end
 
    it "redirects to the new event" do
      post :create, app_id: my_app.id, event: {name: my_event.name}
      event_instance = assigns(:event)
      expect(response).to redirect_to app_event_path(id: event_instance.id, app_id: my_app.id)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, app_id: my_app.id, id: my_event.id
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #edit view" do
      get :edit, app_id: my_app.id, id: my_event.id
      expect(response).to render_template :edit
    end
  
    it "assigns application to be updated to @app" do
      get :edit, app_id: my_app.id, id: my_event.id
  
      event_instance = assigns(:event)
  
      expect(event_instance.id).to eq my_event.id
      expect(event_instance.name).to eq my_event.name
    end
  end

  describe "GET #destroy" do
    it "deletes the event" do
      delete :destroy, {id: my_event.id}
      count = Event.where({id: my_event.id}).size
      expect(count).to eq 0
    end
  
    it "redirects to application" do
      delete :destroy, {id: my_event.id}
      expect(response).to redirect_to app_path(id: my_app.id)
    end
  end
end
