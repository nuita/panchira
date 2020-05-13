# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'fastimage'
require 'json'

require_relative 'panchira/version'
require_relative 'panchira/resolvers/resolver'
require_relative 'panchira/resolvers/dlsite_resolver'
require_relative 'panchira/resolvers/komiflo_resolver'
require_relative 'panchira/resolvers/melonbooks_resolver'
require_relative 'panchira/resolvers/nijie_resolver'
require_relative 'panchira/resolvers/pixiv_resolver'
require_relative 'panchira/resolvers/narou_resolver'

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
      when %r{novel18\.syosetu\.com/}
        Panchira::NarouResolver
      else
        Panchira::Resolver
      end
    end
  end
end
