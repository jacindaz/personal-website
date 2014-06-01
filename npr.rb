class NPR

  def npr_api_xml(key_variable_name)
    key = ENV[key_variable_name]
    uri = URI("http://api.npr.org/query?id=1002&output=XML&apiKey=#{key}")
    response = Net::HTTP.get(uri)
    xml_doc = Nokogiri::XML(response)
    return xml_doc
  end


end
