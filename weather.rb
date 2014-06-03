require_relative 'xml_parse_module.rb'


class Weather

  include ParseXML

  #API Call Methods---------------------------------------------------------------------

  def forecast_xml(city,state)
    uri = URI("http://api.openweathermap.org/data/2.5/forecast/daily?q=#{city},#{state}&mode=xml&units=metric&cnt=7")
    response = Net::HTTP.get(uri)
    xml_doc = Nokogiri::XML(response)
    return xml_doc
  end

  def get_current_weather(city,state)
    uri = URI("http://api.openweathermap.org/data/2.5/weather?q=#{city},#{state}")
    response = Net::HTTP.get(uri)
    weather_data = JSON.parse(response)
    return weather_data
  end

  def weather_icon(icon_id)
    url = "http://openweathermap.org/img/w/#{icon_id}.png"
    return url
  end


  #Kelvin, Celcius, Farenheit Conversion Methods----------------------------------------

  def convert_F(kelvin_temp)
    celcius = kelvin_temp - 273.15
    farenheit = (celcius * 1.8) + 32
    return farenheit
  end

  def celcius_to_faren(hash)
    hash.each do |key,value|
      new_value = (value.to_f * 1.8) + 32
      rounded = new_value.round(1)
      hash[key] = rounded
    end
    return hash
  end

  def celcius_to_faren_num(n)
    farenheit = (n * 1.8) + 32
    return farenheit.to_i
  end

end
