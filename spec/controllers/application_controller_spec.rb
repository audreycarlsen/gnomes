require 'spec_helper'

class DummyController < ApplicationController
  def test_current_user
    redirect_to user_path(@current_user)
  end
end

describe DummyController do

  describe "current_user" do
    it "handles nonexistent users" do

      session[:user_id] = "A"

      get :test_current_user

      expect(response).to redirect_to root_path
      expect(flash[:notice]).to_not be_blank
      expect(session[:user_id]).to be_nil
    end

    it "handles existent users" do
      user = create(:user)
      session[:user_id] = user.id

      get :test_current_user

      expect(assigns(:current_user)).to eq(user)
    end
  end
end