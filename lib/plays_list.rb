require 'nokogiri'
require 'open-uri'

class PlaysList
  attr_reader :html, :document

  def initialize
    @url = "http://www.ibiblio.org/xml/examples/shakespeare/"
    @document = open(@url).read
  end

  def get
    @html = Nokogiri::HTML(document)
    self
  end

  def list
    extract_names_and_urls = lambda do |doc|
      [extact_url(@url, doc), extract_titles(doc)]
    end

    html.css('a').map(&extract_names_and_urls)
  end

  def extact_url(url, document)
    "#{url}#{document['href']}"
  end

  def extract_titles(document)
    document.text
  end
end
