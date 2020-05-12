# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'fastimage'

require 'panchira/version'
require 'panchira/resolvers/resolver'
require 'panchira/resolvers/dlsite_resolver'
# Main Panchira code goes here.
module Panchira
  class << self
    # Fetch the given URL and returns a hash that contains attributes of hentai.
    def fetch(url)
      resolver = select_resolver(url)

      resolver.new(url).fetch
    end

    private

    def select_resolver(url)
      case url
      when %r{komiflo\.com(?:/#!)?/comics/(\d+)}
        Panchira::KomifloResolver
      when %r{melonbooks.co.jp/detail/detail.php\?product_id=(\d+)}
        Panchira::MelonbooksResolver
      when %r{pixiv\.net/(member_illust.php?.*illust_id=|artworks/)(\d+)}
        Panchira::PixivResolver
      when /nijie.*view.*id=\d+/
        Panchira::NijieResolver
      when /dlsite/
        Panchira::DlsiteResolver
      else
        Panchira::Resolver
      end
    end
  end
end
