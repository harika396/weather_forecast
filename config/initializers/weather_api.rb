require 'yaml'
config = (YAML::load(File.open(File.expand_path('../../weather_api.yml', __FILE__))))[::Rails.env]

WeatherForecast::API_HOST     = config['base_url']
WeatherForecast::API_KEY      = config['api_key']
WeatherForecast::GOOGLE_API_SERVER_KEY = config['google_api_server_key']
