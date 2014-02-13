require 'spec_helper'

class DummyController < ApplicationController
  def test_current_user
    redirect_to user_path(@current_user)
  end

  def test_authorize
    redirect_to root_path
  end

  def test_set_weather
    redirect_to root_path
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

  describe "authorize" do
    let(:user) { create(:user) }

    it "redirects if user isn't logged in" do
      session[:user_id] = nil

      get :test_authorize

      expect(response).to redirect_to root_path
    end

    it "doesn't redirect if user is logged in" do
      session[:user_id] = user.id

      get :test_authorize

      expect(response).to_not redirect_to sign_in_path
    end
  end

  describe "set_weather" do
    it "creates an instance of the Barometer class" do
      get :test_set_weather
      expect(assigns(:barometer).class).to be(Barometer::Base)
    end
  end
end