test = [{:number=>"501", :name=>"moderate rain", :var=>"10d"}, {:number=>"500", :name=>"light rain", :var=>"10d"}, {:number=>"500", :name=>"light rain", :var=>"10d"}, {:number=>"500", :name=>"light rain", :var=>"10d"}, {:number=>"502", :name=>"heavy intensity rain", :var=>"10d"}, {:number=>"800", :name=>"sky is clear", :var=>"01d"}, {:number=>"800", :name=>"sky is clear", :var=>"01d"}]


  def icon_url_array(forecast_hash)
    icon_url_array = []
    forecast_hash.each do |day|
      icon_id = day[:var]
      url = weather_icon(icon_id)
      icon_url_array << url
    end
  end

  icon_url_array(test)
