# coding: utf-8
require File.join(File.dirname(__FILE__), %w[.. .. spec_helper])

describe Feedzirra::Parser::RSSEntry do
  before(:each) do
    # I don't really like doing it this way because these unit test should only rely on RSSEntry,
    # but this is actually how it should work. You would never just pass entry xml straight to the AtomEnry
    @entry = Feedzirra::Parser::RSS.parse(sample_rss_feed).entries.first
  end

  it "should parse the title" do
    @entry.title.should == "Nokogiri’s Slop Feature"
  end

  it "should parse the url" do
    @entry.url.should == "http://tenderlovemaking.com/2008/12/04/nokogiris-slop-feature/"
  end

  it "should parse the author" do
    @entry.author.should == "Aaron Patterson"
  end

  it "should parse the content" do
    @entry.content.should == sample_rss_entry_content
  end

  it "should provide a summary" do
    @entry.summary.should == "Oops!  When I released nokogiri version 1.0.7, I totally forgot to talk about Nokogiri::Slop() feature that was added.  Why is it called \"slop\"?  It lets you sloppily explore documents.  Basically, it decorates your document with method_missing() that allows you to search your document via method calls.\nGiven this document:\n\ndoc = Nokogiri::Slop&#40;&#60;&#60;-eohtml&#41;\n&#60;html&#62;\n&#160; &#60;body&#62;\n&#160; [...]"
  end

  it "should parse the published date" do
    @entry.published.to_s.should == "Thu Dec 04 17:17:49 UTC 2008"
  end

  it "should parse the categories" do
    @entry.categories.should == ['computadora', 'nokogiri', 'rails']
  end

  it "should parse the guid as id" do
    @entry.id.should == "http://tenderlovemaking.com/?p=198"
  end

  context "enclosure parsing" do
    before do
      @entry = Feedzirra::Parser::RSS.parse(sample_rss_feed_with_enclosure).entries.first
    end

    it "should parse enclosure type as enclosure_type" do
      @entry.enclosure_type.first.should == "video/ogg"
    end

    it "should parse enclosure length as enclosure_length" do
      @entry.enclosure_length.first.should == "17760378"
    end

    it "should parse enclosure url as enclosure_url" do
      @entry.enclosure_url.first.should == "http://media.vimcasts.org/videos/33/fugitive_3.ogv?referrer=rss"
    end
  end

  context "media rss enclosure parsing" do
    before do
      @entry = Feedzirra::Parser::RSS.parse(sample_media_rss).entries.first
    end

    it "should parse media:content type as enclosure_type" do
      @entry.enclosure_type.should == ["video/quicktime", "video/x-m4v", "video/x-m4v"]
    end

    it "should parse media:content fileSize as enclosure_length" do
      @entry.enclosure_length.should == ["52853783", "23847200", "49904984"]
    end

    it "should parse media:content url as enclosure url" do
      @entry.enclosure_url.should == ["http://blip.tv/file/get/Incredodamn-BigDoucheChillEpisode1BlooperReel427.mov", "http://blip.tv/file/get/Incredodamn-BigDoucheChillEpisode1BlooperReel399.m4v", "http://blip.tv/file/get/Incredodamn-BigDoucheChillEpisode1BlooperReel905.m4v"]
    end
  end
end
