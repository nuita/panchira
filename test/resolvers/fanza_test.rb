# frozen_string_literal: true

require 'test_helper'

class FanzaTest < Minitest::Test
  def test_fetch_fanza_books
    url = 'https://book.dmm.co.jp/detail/b425aakkg00140/'
    result = Panchira.fetch(url)

    assert_match '10から始める英才教育', result.title
    assert_equal 'https://ebook-assets.dmm.co.jp/digital/e-book/b425aakkg00140/b425aakkg00140pl.jpg', result.image.url
  end
end
