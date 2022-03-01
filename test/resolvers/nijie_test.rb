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
    assert_equal 'ジルコン', result.author
    assert_match '抗えない〜', result.description
    assert_includes result.tags, 'バーチャルYouTuber'

    # Picture test for nijie.
    url = 'https://nijie.info/view.php?id=322323'
    result = Panchira.fetch(url)

    # Suffix of picture URI varies by request.
    assert_match 'https://pic.nijie.net/07/nijie/19/65/3965/illust/0_0_fd2ac5566672db1e', result.image.url
    assert_equal 1764, result.image.width
    assert_equal 1876, result.image.height
  end
end
