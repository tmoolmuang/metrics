require 'rails_helper'

RSpec.describe AppsController, type: :controller do
  let(:my_app) { create(:app) }
  
  describe "GET all apps" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  
    it "assigns [my_app] to @apps" do
      get :index
      expect(assigns(:apps)).to eq([my_app])
    end
  end
   
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end
    
    it "instantiates @app" do
      get :new
      expect(assigns(:app)).not_to be_nil
    end
  end
 
  describe "application create" do
    it "increases the number of App by 1" do
      expect{post :create, app: {name: "name", url: "url"} }.to change(App, :count).by(1)
    end

    it "assigns the new application to @app" do
      post :create, app: {name: "name", url: "url"}
      expect(assigns(:app)).to eq App.last
    end

    it "redirects to the new application" do
      post :create, app: {name: "name", url: "url"}
      expect(response).to redirect_to App.last
    end
  end
  
  describe "GET show" do
    it "returns http success" do
      get :show, {id: my_app.id}
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #show view" do
      get :show, {id: my_app.id}
      expect(response).to render_template :show
    end
    
    it "assigns my_app to @app" do
      get :show, {id: my_app.id}
      expect(assigns(:app)).to eq(my_app)
    end
  end
   
  describe "GET edit" do
    it "returns http success" do
      get :edit, {id: my_app.id}
      expect(response).to have_http_status(:success)
    end
  
    it "renders the #edit view" do
       get :edit, {id: my_app.id}
      expect(response).to render_template :edit
    end
  
    it "assigns application to be updated to @app" do
      get :edit, {id: my_app.id}
  
      app_instance = assigns(:app)
  
      expect(app_instance.id).to eq my_app.id
      expect(app_instance.name).to eq my_app.name
      expect(app_instance.url).to eq my_app.url
    end
  end
  
  describe "PUT update" do
    it "updates application with expected attributes" do
      new_name = "new name"
      new_url = "new url"
  
      put :update, id: my_app.id, app: {name: new_name, url: new_url}
  
      updated_app = assigns(:app)
      expect(updated_app.id).to eq my_app.id
      expect(updated_app.name).to eq new_name
      expect(updated_app.url).to eq new_url
    end
  
    it "redirects to the updated application" do
      new_name = "new name"
      new_url = "new url"
  
      put :update, id: my_app.id, app: {name: new_name, url: new_url}
      expect(response).to redirect_to my_app
    end
  end
  
  describe "DELETE destroy" do
    it "deletes the application" do
      delete :destroy, {id: my_app.id}
      count = App.where({id: my_app.id}).size
      expect(count).to eq 0
    end
  
    it "redirects to application index" do
      delete :destroy, {id: my_app.id}
      expect(response).to redirect_to myapps_apps_path
    end
  end
end
