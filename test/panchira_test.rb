# frozen_string_literal: true

require 'test_helper'

class PanchiraTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Panchira::VERSION
  end

  def test_fetch_data_generally
    # hikakinTV
    url = 'https://www.youtube.com/user/HikakinTV'
    result = Panchira.fetch(url)

    assert_equal 'HikakinTV', result.title
    assert_match 'ヒカキン', result.description
    assert result.image.url
    assert result.image.width
    assert result.image.height
    assert_equal 'Panchira::Resolver', result.resolver

    url = 'https://kmc.gr.jp'
    result = Panchira.fetch(url)
    assert_match 'KMC', result.author
  end

  def test_fetch_canonical_url
    url = 'https://blog.hubspot.jp/canonical-url?hogehoge=1'
    result = Panchira.fetch(url)
    assert_equal 'https://blog.hubspot.jp/canonical-url', result.canonical_url

    # it's ok if you don't have canonical url
    url = 'https://example.com/'
    result = Panchira.fetch(url)
    assert_equal 'https://example.com/', result.canonical_url
  end
end
