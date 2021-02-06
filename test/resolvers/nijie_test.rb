# frozen_string_literal: true

require 'test_helper'

class NijieTest < Minitest::Test
  def test_fetch_nijie
    # Canonical url should normalize mobile url.
    url = 'https://sp.nijie.info/view_popup.php?id=319985'
    result = Panchira.fetch(url)

    assert_equal 'Panchira::NijieResolver', result.resolver
    assert_equal 'https://nijie.info/view.php?id=319985', result.canonical_url
    assert_equal '発情めめめ', result.title
    assert_equal 'santatsuki', result.author
    assert_match '抗えない〜', result.description
    assert_includes result.tags, 'バーチャルYouTuber'

    # Fetch thumbnail if the hentai is an animated GIF.
    url = 'http://nijie.info/view.php?id=177736'
    result = Panchira.fetch(url)

    assert_match '__rs_l160x160', result.image.url

    # Picture test for nijie.
    url = 'https://nijie.info/view.php?id=322323'
    result = Panchira.fetch(url)

    assert_equal 'https://pic.nijie.net/05/nijie_picture/3965_20190710041444_0.png', result.image.url
    assert_equal 1764, result.image.width
    assert_equal 1876, result.image.height
  end
end
