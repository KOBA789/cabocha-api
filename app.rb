require 'sinatra'
require 'cabocha'
require 'sinatra/cross_origin'

helpers do
  def html_safe(text)
    Rack::Utils.escape_html(text)
  end
end

get '/cabocha.xml' do
  parser = CaboCha::Parser.new
  tree = parser.parse(params["q"].to_s)
  @result = tree.toString(CaboCha::CABOCHA_FORMAT_XML)

  content_type "application/xml", charset: "utf8"
  cross_origin

  erb :xml
end

get '/cabocha.txt' do
  parser = CaboCha::Parser.new
  tree = parser.parse(params["q"].to_s)
  @result = tree.toString(CaboCha::CABOCHA_FORMAT_TREE)

  content_type "text/plain", charset: "utf8"
  cross_origin

  @result
end

__END__

@@xml
<?xml version="1.0" encoding="UTF-8"?>
<%= @result %>
