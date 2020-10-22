# frozen_string_literal: true

require 'test_helper'

class FanzaTest < Minitest::Test
  def test_fetch_fanza_books
    url = 'https://book.dmm.co.jp/detail/b425aakkg00140/'
    result = Panchira.fetch(url)

    assert_match '10から始める英才教育', result.title
    assert_equal 'https://ebook-assets.dmm.co.jp/digital/e-book/b425aakkg00140/b425aakkg00140pl.jpg', result.image.url
    assert result.tags.include?('ミニ系')

    # the url above doesn't have description, so try with different one:
    url = 'https://book.dmm.co.jp/detail/k180atkds00971/?dmmref=aComic_List&i3_ord=3&i3_ref=list'
    result = Panchira.fetch(url)
    assert_match 'わんぴいす〜美少女捕獲し、日本一周〜', result.title
    assert_match '※強〇は犯罪です。絶対に手口を模倣しないでください。', result.description
    assert_equal 'クジラックス', result.author
  end

  def test_fetch_fanza_doujin
    url = 'https://www.dmm.co.jp/dc/doujin/-/detail/=/cid=d_184301/'
    result = Panchira.fetch(url)

    assert_match 'げーみんぐはーれむ', result.title
    assert_match '不登校でゲームセンスだけが取り柄の僕は日々培った実力を試すべく、', result.description
    assert_equal '笹森トモエ', result.circle
    assert result.tags.include?('逆転無し')

    # og:image in Doujin looks large enough.
    assert_equal 'https://doujin-assets.dmm.co.jp/digital/comic/d_184301/d_184301pr.jpg', result.image.url
  end
end
