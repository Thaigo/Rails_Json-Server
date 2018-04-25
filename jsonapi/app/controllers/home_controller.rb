class HomeController < ApplicationController
  require 'rest-client'
  require 'json'

  BASE_URL = "http://localhost:3009"

  def index
    value = RestClient.get "#{BASE_URL}/users"

    @users = JSON.parse(value, :symbolize_names => true)
  end

  def new
    
  end

  def create
    url = "#{BASE_URL}/users"
    payload = params.to_json
    value = RestClient::Resource.new(url)
    begin
      value.post payload, :content_type => "application/json"
      flash[:notice] = "User saved"
      redirect_to root_url
    rescue Exception => e
      flash[:error] = "User failed to save"
      render :new
    end
  end

  def edit
    url = "#{BASE_URL}/users/#{params[:id]}"
    value = RestClient::Resource.new(url)
    
    users = value.get
    @user = JSON.parse(users, :symbolize_names => true)
  end

  def update
    url = "#{BASE_URL}/users/#{params[:id]}"
    payload = params.to_json
    value = RestClient::Resource.new(url)

    begin
      value.put payload, :content_type => "application/json"
      flash[:notice] = "User Updated"      
    rescue Exception => e
      flash[:error] = "User failed to save"
    end
      redirect_to root_url
  end
  
  def destroy
    url = "#{BASE_URL}/users/#{params[:id]}"
    value = RestClient::Resource.new(url)
    
    begin
      value.delete
      flash[:notice] = "User Deleted" 
    rescue Exception => e
      flash[:error] = "User failed to save"
    end
      redirect_to root_url        
  end
  
  
end



