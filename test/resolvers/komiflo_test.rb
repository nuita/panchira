# frozen_string_literal: true

require 'test_helper'

class KomifloTest < Minitest::Test
  def test_fetch_komiflo
    url = 'https://komiflo.com/#!/comics/4635/read/page/3'
    result = Panchira.fetch(url)

    assert_equal 'https://komiflo.com/comics/4635', result.canonical_url
    assert_match '晴れ時々露出予報', result.title
    assert_match 'NAZ', result.description
    assert_equal 'https://t.komiflo.com/564_mobile_large_3x/contents/cdcfb81ea67a74519b8ad9dea6de8c5d4cec9f9f.jpg', result.image.url
    assert_equal %w(オナニー ムリヤリ 幼児体型 痴女 貧乳・微乳 野外・露出).sort, result.tags.sort
  end
end
