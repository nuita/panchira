# frozen_string_literal: true

require 'test_helper'

class MelonbooksTest < Minitest::Test 
  def test_fetch_melonbooks
    url = 'https://www.melonbooks.co.jp/detail/detail.php?product_id=319663'

    attributes = Panchira.fetch(url)
    assert_match 'https://www.melonbooks.co.jp/detail/detail.php?product_id=319663&adult_view=1', attributes[:canonical_url]
    assert_match 'めちゃシコごちうさアソート', attributes[:title]
    assert_match 'image=212001143963.jpg', attributes[:image][:url]
    assert_match (/^(?!.*c=1).*$/), attributes[:image][:url]
    assert_match 'めちゃシコシリーズ', attributes[:description]

    # Page structure in melonbooks changes if there is a review from staff.
    url = 'https://www.melonbooks.co.jp/detail/detail.php?product_id=242938'
    
    attributes = Panchira.fetch(url)
    assert_match 'ぬめぬめ', attributes[:title]
    assert_match '諏訪子様にショタがいじめられる話です。', attributes[:description] # kawaisou...
  end
end
