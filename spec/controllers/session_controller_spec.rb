require 'spec_helper'

describe SessionController do
  before do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
  end

  describe "#create" do
    it "should successfully create a user" do
      expect {
        post :create, provider: :twitter
      }.to change{ User.count }.by(1)
    end

    it "should successfully create a session" do
      expect(session[:user_id]).to be_nil
      post :create, provider: :twitter
      expect(session[:user_id]).to_not be_nil
    end

    it "should redirect the user to the root url" do
      post :create, provider: :twitter
      response.should redirect_to root_url
    end
  end
end
