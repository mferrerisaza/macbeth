require 'nokogiri'

class XmlSource
  def initialize(path)
    @path = path
  end

  def source
    document = open(@path).read
    xml = Nokogiri::XML(document)
  end
end
