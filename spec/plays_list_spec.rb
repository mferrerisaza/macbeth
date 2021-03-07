require 'spec_helper'
require 'byebug'

describe PlaysList do
  before do
    path = path = "spec/fixtures/list.html"
    response = File.new(path).read
    stub_request(:get, /.*www.ibiblio.org.*/).to_return(response)
  end

  subject { PlaysList.new }

  describe '#list' do
    it 'returns play list' do
      expected = [
        ["http://www.ibiblio.org/xml/examples/shakespeare/all_well.xml", "All's Well That Ends Well"],
        ["http://www.ibiblio.org/xml/examples/shakespeare/as_you.xml", "As You Like It"]
      ]
      expect(subject.get.list).to include(*expected)
    end
  end

  describe '#get' do
    it 'it sets the @html variable and returns a PlayList instance' do
      expect(subject.get).to be_a PlaysList
      expect(subject.get.html).to be_a Nokogiri::HTML::Document
    end
  end

end
