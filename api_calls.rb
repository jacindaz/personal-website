class ApiCalls

  def return_xml(key_variable_name,api_url)
    key = ENV[key_variable_name]
    uri = URI("#{api_url}#{key}")
    response = Net::HTTP.get(uri)
    xml_file = Nokogiri::XML(response)
    return xml_file
  end


end
