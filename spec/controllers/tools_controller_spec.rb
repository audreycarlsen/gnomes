require 'spec_helper'

describe ToolsController do

  let(:default_tool) { create(:tool) }
  let(:valid_attributes) { {title: "rake"} }

  context "if user isn't an admin" do
    let(:user) { create(:user) }

    before(:each) do
      session[:user_id] = user.id
    end

    it 'GET#index is successful' do
      get :index
      expect(response).to be_successful
    end

    it 'redirects from GET#new' do
      get :new
      expect(response).to redirect_to root_path
    end

    it 'redirects from GET#edit' do
      get :edit, id: default_tool.id
      expect(response).to redirect_to root_path
    end

    it 'redirects from POST#create' do
      post :create, tool: valid_attributes
      expect(response).to redirect_to root_path
    end

    it 'GET#show is successful' do
      get :show, id: default_tool.id
      expect(response).to be_successful
    end

    it 'redirects from PATCH#update' do
      patch :update, id: default_tool.id, tool: { title: "This is a turbo rake" }
      expect(response).to redirect_to root_path
    end

    it 'redirects from DELETE#destroy' do
      delete :destroy, id: default_tool.id
      expect(response).to redirect_to root_path
    end

    describe 'reserve_tool' do
      it "assigns tool to user" do
        expect(default_tool.user_id).to be_nil
        patch :reserve_tool, id: default_tool.id
        expect(default_tool.reload.user_id).to eq(user.id)
      end

      it "redirects" do
        patch :reserve_tool, id: default_tool.id
        expect(response).to redirect_to tool_path(default_tool.id)
      end
    end

    describe 'return_tool' do
      let!(:default_tool) { create(:tool, user_id: user.id) }

      it "resets tool's user_id to nil" do
        expect(default_tool.user_id).to eq(user.id)
        patch :return_tool, id: default_tool.id
        expect(default_tool.reload.user_id).to be_nil
      end

      it "redirects" do
        patch :reserve_tool, id: default_tool.id
        expect(response).to redirect_to tool_path(default_tool.id)
      end
    end
  end

  context "if user is an admin" do
    let(:default_admin) { create(:admin) }

    before(:each) do
      session[:user_id] = default_admin.id
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
          post :create, tool: valid_attributes
          expect(response.status).to eq 302
        end

        it "changes post count by 1" do
          expect { post :create, tool: valid_attributes }.to change(Tool, :count).by(1)
        end

        it "sets a flash message" do
          post :create, tool: valid_attributes
          expect(flash[:notice]).to_not be_blank
        end
      end

      context "with invalid attributes" do
        it "renders the new template" do
          post :create, tool: {title: nil}
          expect(response).to render_template :new
        end

        it "does not create a tool" do
          expect { post :create, tool: {title: nil} }.to change(Tool, :count).by(0)
        end
      end
    end

    describe "GET 'show'" do
      it "is successful" do
        get :show, id: default_tool.id
        expect(response).to be_successful
      end
    end

    describe "GET 'edit'" do
      it "is successful" do
        get :edit, id: default_tool.id
        expect(response).to be_successful
      end
    end

    describe "PATCH 'update'" do
      it 'to redirect and update' do
        patch :update, id: default_tool.id, tool: { title: "This is a turbo rake" }

        expect(default_tool.reload.title). to eq("This is a turbo rake")
        expect(response).to redirect_to tool_path(default_tool.id)
      end
    end

    describe "DELETE 'destroy'" do
      let!(:default_tool) { create(:tool) }

      it "is a redirect" do
        delete :destroy, id: default_tool.id
        expect(response).to redirect_to tools_path
      end

      it "decreases tool count by 1" do
        expect { delete :destroy, id: default_tool.id }.to change(Tool, :count).by(-1)
      end
    end
  end

end
