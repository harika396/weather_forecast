class WeatherController < ApplicationController
	before_action :validate_search_query, :only => [:search]

  require 'net/http'
  require 'json'

	def index
	end

	def search
		@search_key = params[:locality]+","+params[:administrative_area_level_1]+","+params[:country]
	  response = weather_forecast_for(@search_key)
	  extended_response = extended_forecast_for(response["coord"]) 
	  
	  if @search_key.blank? || response["cod"] != 200
	    flash.now[:alert] = 'Address not found'
	    return render action: :index
	  else
	  	@forecast = helpers.build_weather_forecast_data_for(response, extended_response)
	  end
  end

  private

  def request_api(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def weather_forecast_for(query)
    request_api(
      "#{WeatherForecast::API_HOST}/weather?q=#{URI.encode(query)}&appid=#{WeatherForecast::API_KEY}"
    )
  end

  def extended_forecast_for(coordinates)
  	request_api(
  	  "#{WeatherForecast::API_HOST}/onecall?lat=#{coordinates["lat"]}&lon=#{coordinates["lon"]}&exclude=current,minutely,hourly&appid=#{WeatherForecast::API_KEY}"
  	)
  end

  def validate_search_query
  	if params[:locality].blank? && params[:administrative_area_level_1].blank? && params[:country].blank?
  		flash.now[:warning] = "Enter a valid address"
  		return render action: :index
  	end
  end

end
