helpers do

  def base_stylesheets
    if settings.base_styles
      puts "=========================================================="
      styles = []
      settings.base_styles.each do |stylesheet|
        puts "Loading base CSS styles: #{stylesheet}..."
        styles << "<link rel=\"stylesheet\" href=\"/css/#{stylesheet}\">"
      end
    end
    puts "Finished loading base CSS stylesheets"
    puts "==========================================================\n"
    styles
  end

  def base_javascripts
    if settings.base_js
      puts "=========================================================="
      javascript_files = []
      settings.base_js.each do |js|
        puts "Loading base external javascript sheets: #{js}"
        javascript_files << "<script type=\"text/javascript\" src=\"/js/#{js}\"></script>"
      end
    end
    puts "Finished loading base JavaScript sheets"
    puts "==========================================================\n"
    javascript_files
  end

end
