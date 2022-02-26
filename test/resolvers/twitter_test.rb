# frozen_string_literal: true

require 'test_helper'

class TwitterTest < Minitest::Test
  def test_fetch_twitter
    url = 'https://twitter.com/bot_erection/status/1412029253906886657'
    result = Panchira.fetch(url)

    assert_match '勃起タイムbot', result.title

    # delete author test temporarily due to sudden change
    # assert_equal '勃起タイムbot', result.author

    assert_equal '君は中学生なのになかなかの勃起サイズをしているね？', result.description
    assert_match 'https://pbs.twimg.com/media', result.image.url

    # ハッシュタグのテスト
    url = 'https://twitter.com/atahuta_/status/1360990273619193860'
    result = Panchira.fetch(url)

    assert_equal 'paizuri_watson #hololewd #amelewd', result.description
    assert_equal ['hololewd', 'amelewd'], result.tags
  end
end
