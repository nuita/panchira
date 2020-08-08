# frozen_string_literal: true

require 'test_helper'

class FanzaTest < Minitest::Test
  def test_fetch_fanza_books
    url = 'https://book.dmm.co.jp/detail/b425aakkg00140/'
    result = Panchira.fetch(url)

    assert_match '10から始める英才教育', result.title
    assert_equal 'https://ebook-assets.dmm.co.jp/digital/e-book/b425aakkg00140/b425aakkg00140pl.jpg', result.image.url
  end

  def test_fetch_fanza_doujin
    url = 'https://www.dmm.co.jp/dc/doujin/-/detail/=/cid=d_184301/'
    result = Panchira.fetch(url)

    assert_match 'げーみんぐはーれむ', result.title
    assert_match '不登校でゲームセンスだけが取り柄の僕は日々培った実力を試すべく、', result.description
    assert result.tags.include?('逆転無し')

    # og:image in Doujin looks large enough.
    assert_equal 'https://doujin-assets.dmm.co.jp/digital/comic/d_184301/d_184301pr.jpg', result.image.url
  end
end
