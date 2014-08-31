helpers do

  def base_stylesheets
    if settings.base_styles
      styles = []
      settings.base_styles.each do |stylesheet|
        styles << "<link rel=\"stylesheet\" href=\"/css/#{stylesheet}\">"
      end
    end
    styles
  end

  def base_javascripts
    if settings.base_js
      javascript_files = []
      settings.base_js.each do |js|
        javascript_files << "<script type=\"text/javascript\" src=\"/js/#{js}\"></script>"
      end
    end
    javascript_files
  end

end
