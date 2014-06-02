class NPR

  def npr_api_xml(key_variable_name, url)
    key = ENV[key_variable_name]
    uri = URI("#{url}&apiKey=#{key}")
    response = Net::HTTP.get(uri)
    xml_doc = Nokogiri::XML(response)
    return xml_doc
  end


end
