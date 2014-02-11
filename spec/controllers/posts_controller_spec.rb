require 'spec_helper'

describe PostsController do
  describe "GET 'new'" do
    it "is successful" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST 'create'" do
    context "with valid attributes" do
      let(:valid_attributes) { {title: "Breaking News", content: "Some things happened"} }
      it "is a redirect" do
        post :create, post: valid_attributes
        expect(response.status).to eq 302 # This is a redirect
      end

      it "changes post count by 1" do
        expect { post :create, post: valid_attributes }.to change(Post, :count).by(1)
      end

      it "sets a flash message" do
        post :create, post: valid_attributes
        expect(flash[:notice]).to_not be_blank
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
    let(:post) { create(:post) }
    it "is successful" do
      get :show, id: post.id
      expect(response).to be_successful
    end
  end

  describe "GET 'edit'" do
    let(:post) { create(:post) }
    it "is successful" do
      get :show, id: post.id
      expect(response).to be_successful
    end
  end
end
