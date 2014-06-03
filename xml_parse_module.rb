module ParseXML

  def xml_array_nested_hash(xml_file_path, xml_doc)
    array_of_hashes = []
    nested_hash = {}
    xml_doc.xpath(xml_file_path).each do |elements|
      #puts "outer loop: attributes #{attributes}"
      elements.each do |key, value|
        #puts "each loop: key/value is #{key}, #{value}"
        nested_hash[key.to_sym] = value
      end
      array_of_hashes << nested_hash
    end
    return array_of_hashes
  end


end
