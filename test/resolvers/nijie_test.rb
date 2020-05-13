# frozen_string_literal: true

require 'test_helper'

class NijieTest < Minitest::Test 
  def test_fetch_nijie
    # Canonical url should normalize mobile url.
    url = 'https://sp.nijie.info/view_popup.php?id=319985'
    attributes = Panchira.fetch(url)

    assert_equal 'https://nijie.info/view.php?id=319985', attributes[:canonical_url]
    assert_match '発情めめめ', attributes[:title]

    # Fetch thumbnail if the hentai is an animated GIF.
    url = 'http://nijie.info/view.php?id=177736'
    attributes = Panchira.fetch(url)

    assert_match '__rs_l160x160', attributes[:image][:url]

    # Picture test for nijie.
    url = 'https://nijie.info/view.php?id=322323'
    attributes = Panchira.fetch(url)

    assert_equal 'https://pic.nijie.net/05/nijie_picture/3965_20190710041444_0.png', attributes[:image][:url]
    assert_equal 1764, attributes[:image][:width]
    assert_equal 1876, attributes[:image][:height]
  end
end
