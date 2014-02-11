require 'spec_helper'

describe PostsController do
  
  let(:default_post) { create(:post) }

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
      post :create, post: { title: "Breaking News", content: "Some things happened" }
      expect(response).to redirect_to root_path
    end

    it 'GET#show is successful' do
      get :show, id: default_post.id
      expect(response).to be_successful
    end

    it 'redirects from GET#update' do
      patch :update, id: default_post.id
      expect(response).to redirect_to root_path
    end

    it 'redirects from GET#destroy' do
      get :destroy, id: default_post.id
      expect(response).to redirect_to root_path
    end
  end




  # describe "GET 'new'" do
  #   context 'if user is admin' do

    # let(:admin) { create(:admin) }

  #     it "is successful" do
  #       get :new
  #       expect(response).to be_successful
  #     end
  #   end


  # end

  # describe "POST 'create'" do
  #   context "with valid attributes" do
      
  #     it "is a redirect" do
  #       post :create, post: valid_attributes
  #       expect(response.status).to eq 302 # This is a redirect
  #     end

  #     it "changes post count by 1" do
  #       expect { post :create, post: valid_attributes }.to change(Post, :count).by(1)
  #     end

  #     it "sets a flash message" do
  #       post :create, post: valid_attributes
  #       expect(flash[:notice]).to_not be_blank
  #     end
  #   end

  #   context "with invalid attributes" do
  #     it "renders the new template" do
  #       post :create, post: {title: nil}
  #       expect(response).to render_template :new
  #     end

  #     it "does not create a post" do
  #       expect { post :create, post: {title: nil} }.to change(Post, :count).by(0)
  #     end
  #   end
  # end

  # describe "GET 'show'" do
  #   let(:post) { create(:post) }
  #   it "is successful" do
  #     get :show, id: post.id
  #     expect(response).to be_successful
  #   end
  # end

  # describe "GET 'edit'" do
  #   let(:post) { create(:post) }
  #   it "is successful" do
  #     get :edit, id: post.id
  #     expect(response).to be_successful
  #   end
  # end
end
