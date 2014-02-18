require 'spec_helper'

describe PostsController do
  
  let(:default_post) { create(:post) }
  let(:valid_attributes) { {title: "Breaking News", content: "Some things happened"} }

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
      get :edit, id: default_post.id
      expect(response).to redirect_to root_path
    end

    it 'redirects from POST#create' do
      post :create, post: valid_attributes
      expect(response).to redirect_to root_path
    end

    it 'GET#show is successful' do
      get :show, id: default_post.id
      expect(response).to be_successful
    end

    it 'redirects from PATCH#update' do
      patch :update, id: default_post.id
      expect(response).to redirect_to root_path
    end

    it 'redirects from DELETE#destroy' do
      delete :destroy, id: default_post.id
      expect(response).to redirect_to root_path
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
      let!(:user)  { create(:user) }
      let!(:user2) { create(:user) }

      context "with valid attributes" do

        before(:each) do
          ActionMailer::Base.delivery_method = :test
          ActionMailer::Base.perform_deliveries = true
          ActionMailer::Base.deliveries = []
        end

        after(:each) do
          ActionMailer::Base.deliveries.clear
        end

        before do
          ResqueSpec.reset!
        end
        
        it "is a redirect" do
          post :create, post: valid_attributes
          expect(response.status).to eq 302
        end

        it "changes post count by 1" do
          expect { post :create, post: valid_attributes }.to change(Post, :count).by(1)
        end

        it "sets a flash message" do
          post :create, post: valid_attributes
          expect(flash[:notice]).to_not be_blank
        end

        # it 'sends an email' do
        #   without_resque_spec do
        #     post :create, post: valid_attributes
        #     expect{ NewsMailer.new_post(assigns(:post).id, user.id).deliver }.to change(ActionMailer::Base.deliveries.count).by(1)
        #   end
        # end

        # it "sends to user's email address" do
        #   without_resque_spec do
        #     post :create, post: valid_attributes
        #     NewsMailer.new_post(assigns(:post).id, user.id).deliver
        #     expect(ActionMailer::Base.deliveries.last).to eq(user.email)
        #   end
        # end

        it "should have a queue size of 2" do
          post :create, post: valid_attributes
          EmailJob.should have_queue_size_of(2)
        end

        it "adds NewsMailer.new_post to the Email queue" do
          post :create, post: valid_attributes
          EmailJob.should have_queued(assigns(:post).id, user.id)
          EmailJob.should have_queued(assigns(:post).id, user2.id)
        end
      end

      context "with invalid attributes" do
        it "renders the new template" do
          post :create, post: {title: nil}
          expect(response).to render_template :new
        end

        it "does not create a post" do
          expect { post :create, post: {title: nil} }.to change(Post, :count).by(0)
        end
      end
    end

    describe "GET 'show'" do
      it "is successful" do
        get :show, id: default_post.id
        expect(response).to be_successful
      end
    end

    describe "GET 'edit'" do
      it "is successful" do
        get :edit, id: default_post.id
        expect(response).to be_successful
      end
    end

    describe "PATCH 'update'" do
      it 'to redirect and update' do
        patch :update, id: default_post.id, post: { title: "This is a new title" }

        expect(default_post.reload.title). to eq("This is a new title")
        expect(response).to redirect_to post_path(default_post.id)
      end
    end

    describe "DELETE 'destroy'" do
      let!(:default_post) { create(:post) }
      
      it "is a redirect" do
        delete :destroy, id: default_post.id
        expect(response).to redirect_to root_path
      end

      it "decreases post count by 1" do
        expect { delete :destroy, id: default_post.id }.to change(Post, :count).by(-1)
      end
    end
  end
end
