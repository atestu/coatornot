require 'rubygems'
require 'sinatra'
require 'hpricot'
require 'rest-open-uri'

get '/:city' do
  doc = open("http://www.google.com/ig/api?weather=#{params[:city].gsub(" ", "%20")}") { |f| Hpricot(f) }
  @temperature = doc.at("temp_c")['data'].to_i
  @farenheit = doc.at("temp_f")['data'].to_i
  
  @message1 = "It's " + @temperature.to_s + "°C/" + @farenheit.to_s + "°F outside, so… "
  @message2 = ""
  if @temperature > 15 then
    @yesorno = "No Coat"
  else
    if @temperature > 10
      @yesorno = "Meh"
      @message2 = "If you put one on, you'll be too hot and if you don't you'll be cold.<br /> Life's a bitch sometimes."
    else
      @yesorno = "Coat"
    end
  end
  @city = params[:city]

  erb :hello
end


get '/' do
  erb :index
end

post '/' do
  redirect "/#{params[:post][:city]}"
end
