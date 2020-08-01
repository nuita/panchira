# frozen_string_literal: true

require 'test_helper'

class FanzaTest < Minitest::Test
  def test_fetch_fanza_book
    url = 'https://book.dmm.co.jp/detail/b425aakkg00140/'
    result = Panchira.fetch(url)

    assert_match '10から始める英才教育', result.title
  end
end
