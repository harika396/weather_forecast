module ApplicationHelper
	
  def temp_converter(kelvin_temp)
  	celsius_temp = (kelvin_temp - 273.15).floor
  	fahrenheit_temp = (celsius_temp * (9.0/5.0) + 32).floor
    {celcius: "#{celsius_temp}°C", fahrenheit: "#{fahrenheit_temp}ºF"}
  end

  def to_day_of_the_week(dt)
		t = Time.at(dt)
		date = t.to_date
		date.strftime('%a')
  end

end
