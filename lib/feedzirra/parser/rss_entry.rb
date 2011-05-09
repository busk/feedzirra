module Feedzirra

  module Parser
    # == Summary
    # Parser for dealing with RDF feed entries.
    #
    # == Attributes
    # * title
    # * url
    # * author
    # * content
    # * summary
    # * published
    # * categories
    class RSSEntry
      include SAXMachine
      include FeedEntryUtilities
      element :title
      element :link, :as => :url

      element :"dc:creator", :as => :author
      element :author, :as => :author
      element :"content:encoded", :as => :content
      element :description, :as => :summary

      element :pubDate, :as => :published
      element :pubdate, :as => :published
      element :"dc:date", :as => :published
      element :"dc:Date", :as => :published
      element :"dcterms:created", :as => :published


      element :"dcterms:modified", :as => :updated
      element :issued, :as => :published
      elements :category, :as => :categories

      element :guid, :as => :entry_id

      elements :enclosure, :value => :type, :as => :enclosure_type
      elements :enclosure, :value => :length, :as => :enclosure_length
      elements :enclosure, :value => :url, :as => :enclosure_url

      elements :"media:content", :value => :type, :as => :enclosure_type
      elements :"media:content", :value => :fileSize, :as => :enclosure_length
      elements :"media:content", :value => :url, :as => :enclosure_url
    end

  end

end
