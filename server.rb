require 'sinatra'
require 'cabocha'

helpers do
  def html_safe(text)
    Rack::Utils.escape_html(text)
  end
end

get '/' do
  parser = CaboCha::Parser.new
  tree = parser.parse(params["q"].to_s)
  @result = tree.toString(CaboCha::CABOCHA_FORMAT_XML)

  content_type "application/xml", charset: "utf8"
  cross_origin

  erb :index
end

__END__

@@index
<?xml version="1.0" encoding="UTF-8"?>
<%= @result %>
