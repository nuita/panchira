# frozen_string_literal: true

require 'test_helper'

class PixivTest < Minitest::Test
  def test_fetch_pixiv
    # This art is not matured content, but look at this cute girl!
    url = 'https://www.pixiv.net/member_illust.php?mode=medium&illust_id=73718144'
    result = Panchira.fetch(url)

    assert_equal 'Panchira::PixivResolver', result.resolver
    assert_equal 'んあー・・・', result.title
    assert_match 'ん？あげませんよ！', result.description
    assert_match 'パイングミ', result.author
    assert_equal 'https://pixiv.cat/73718144.jpg', result.image.url
    assert_includes result.tags, 'VOICEROID'

    # Fetch the first page if it is manga.
    url = 'https://www.pixiv.net/member_illust.php?mode=medium&illust_id=75871400'
    result = Panchira.fetch(url)

    assert_equal 'DWU', result.title
    assert_match '浅瀬', result.description
    assert_match 'かにかま', result.author
    assert_equal 'https://pixiv.cat/75871400-1.jpg', result.image.url
    assert_includes result.tags, 'DWU'

    # Look at this new url format.
    url = 'https://www.pixiv.net/artworks/55434358'
    result = Panchira.fetch(url)

    assert_equal 'ああ～心がぴょんぴょんするんじゃ～', result.title
    assert_match 'Pietのプログラムのソースコード', result.description
    assert_match 'むらため', result.author
    assert_equal 'https://pixiv.cat/55434358-1.jpg', result.image.url
    assert_includes result.tags, 'Piet'
  end

  def test_fetch_pixiv_novel
    # This test case would never be broken.
    url = 'https://www.pixiv.net/novel/show.php?id=14623881'
    result = Panchira.fetch(url)

    assert_equal '後輩', result.title
    assert_equal 'newkyp', result.author
    assert_match 'おしっこの描写、その他残酷な描写があります', result.description
    assert_includes result.tags, '巨大娘'
  end
end
