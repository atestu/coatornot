require 'rubygems'
require 'sinatra'
require 'hpricot'
require 'rest-open-uri'

mime_type '.otf',  "application/x-font-otf"

get '/:city' do
  doc = open("http://www.google.com/ig/api?weather=#{params[:city]}") { |f| Hpricot(f) }
  @temperature = doc.at("temp_c")['data']
  
  if @temperature > "15" then
    @yesorno = "No"
  else
    if @temperature > "10"
      @yesorno = "Meh"
    else
      @yesorno = "Yes"
    end
  end
  @message = "It's " + @temperature + "°C outside."
  erb :hello
end
