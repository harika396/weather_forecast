module WeatherHelper
	def build_weather_forecast_data_for(fc, extended_fc)
	 	forecast = Hash.new
	 	extended_data = []
    extended_fc["daily"][1..-1].each_with_index do |fc,i|
    	extended_data << {
    	 :day => to_day_of_the_week(fc["dt"]),
    	 :min_temp => temp_converter(fc['temp']['min']),
  		 :max_temp => temp_converter(fc['temp']['max']),
  		 :icon => fc['weather'][0]['icon'] 
  		}
    end
  	forecast = {
	  	:current => temp_converter(fc['main']['temp']),
	  	:minimum => temp_converter(fc['main']['temp_min']),
	  	:maximum => temp_converter(fc['main']['temp_max']),
	  	:country => fc['sys']['country'],
	  	:state => fc['name'],
	  	:postal_code => params[:postal_code],
	  	:icon => fc['weather'][0]['icon'],
	  	:extended => extended_data
	  }
	end
end
