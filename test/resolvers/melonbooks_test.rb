# frozen_string_literal: true

require 'test_helper'

class MelonbooksTest < Minitest::Test
  def test_fetch_melonbooks
    url = 'https://www.melonbooks.co.jp/detail/detail.php?product_id=319663'

    result = Panchira.fetch(url)
    assert_match 'https://www.melonbooks.co.jp/detail/detail.php?product_id=319663&adult_view=1', result.canonical_url
    assert_match 'めちゃシコごちうさアソート', result.title
    assert_match 'image=212001143963.jpg', result.image.url
    assert_match(/^(?!.*c=1).*$/, result.image.url)
    assert_match 'めちゃシコシリーズ', result.description
    assert_equal %w[2017年12月新刊同人作品特集 C93 C93・コミケ3日目 C93同人誌 C93成年同人誌 ご注文はうさぎですか? ココア コミックマーケット93 シャロ チノ フルカラー 総集編 萌え].sort, result.tags.sort

    # Page structure in melonbooks changes if there is a review from staff.
    url = 'https://www.melonbooks.co.jp/detail/detail.php?product_id=242938'

    result = Panchira.fetch(url)
    assert_match 'ぬめぬめ', result.title
    assert_match '諏訪子様にショタがいじめられる話です。', result.description # kawaisou...
  end
end
