require 'spec_helper'

describe EventsController do
  let(:default_user) { create(:user) }
  let(:default_event) { create(:event) }
  let(:valid_attributes) { {title: "Awesome Event", description: "You know you wanna.", date: "2014-02-11 13:56:20 -0800", location: "My place"} }

  context "if user isn't logged in" do
    before(:each) do
      session[:user_id] = nil
    end

    it 'GET#index is successful' do
      get :index
      expect(response).to be_successful
    end

    it 'redirects from GET#new' do
      get :new
      expect(response).to redirect_to sign_in_path
    end

    it 'redirects from GET#edit' do
      get :edit, id: default_event.id
      expect(response).to redirect_to sign_in_path
    end

    it 'redirects from POST#create' do
      post :create, post: valid_attributes
      expect(response).to redirect_to sign_in_path
    end

    it 'GET#show is successful' do
      get :show, id: default_event.id
      expect(response).to be_successful
    end

    it 'redirects from PATCH#update' do
      patch :update, id: default_event.id
      expect(response).to redirect_to sign_in_path
    end

    it 'redirects from DELETE#destroy' do
      delete :destroy, id: default_event.id
      expect(response).to redirect_to sign_in_path
    end

    it 'redirects from POST#rsvp' do
      post :rsvp, id: default_event.id, response: "yes"
      expect(response).to redirect_to sign_in_path
    end

    it 'redirects from DELETE#rsvp_no' do
      delete :rsvp_no, id: default_event.id
      expect(response).to redirect_to sign_in_path
    end
  end

  context "if user is logged in" do
    before(:each) do
      session[:user_id] = default_user.id
    end

    describe "GET 'new'" do
      it "is successful" do
        get :new
        expect(response).to be_successful
      end
    end

    describe "POST 'create'" do
      context "with valid attributes" do
        
        it "is a redirect" do
          post :create, event: valid_attributes
          expect(response.status).to eq 302
        end

        it "changes event count by 1" do
          expect { post :create, event: valid_attributes }.to change(Event, :count).by(1)
        end

        it "belongs to current user" do
          post :create, event: valid_attributes
          expect { assigns(:event).user_id }.to eq(default_user.id)
        end

        it "sets a flash message" do
          post :create, event: valid_attributes
          expect(flash[:notice]).to_not be_blank
        end
      end

      context "with invalid attributes" do
        it "renders the new template" do
          post :create, event: {title: nil}
          expect(response).to render_template :new
        end

        it "does not create a post" do
          expect { post :create, event: {title: nil} }.to change(Event, :count).by(0)
        end
      end
    end

    describe "GET 'show'" do
      it "is successful" do
        get :show, id: default_event.id
        expect(response).to be_successful
      end
    end

    describe "GET 'edit'" do
      it "is successful" do
        get :edit, id: default_event.id
        expect(response).to be_successful
      end
    end

    describe "PATCH 'update'" do
      it 'to redirect and update' do
        patch :update, id: default_event.id, event: { title: "This is a new title" }

        expect(default_event.reload.title). to eq("This is a new title")
        expect(response).to redirect_to event_path(default_event.id)
      end
    end

    describe "DELETE 'destroy'" do
      let!(:default_event) { create(:event) }
      
      it "is a redirect" do
        delete :destroy, id: default_event.id
        expect(response).to redirect_to events_path
      end

      it "decreases post count by 1" do
        expect { delete :destroy, id: default_event.id }.to change(Event, :count).by(-1)
      end
    end
  end

end
