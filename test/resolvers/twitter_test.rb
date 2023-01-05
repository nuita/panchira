# frozen_string_literal: true

require 'test_helper'

class TwitterTest < Minitest::Test
  def test_fetch_twitter
    url = 'https://twitter.com/bot_erection/status/1412029253906886657'
    result = Panchira.fetch(url)

    assert_match '勃起タイムbot', result.title
    assert_equal '勃起タイムbot', result.author

    assert_equal '君は中学生なのになかなかの勃起サイズをしているね？', result.description
    assert_match 'https://pbs.twimg.com/media', result.image.url
  end

  # To test this case, you have to set environment variable TWITTER_BEARER_TOKEN.
  def test_fetch_twitter_from_api
    bearer_token = ENV.fetch('TWITTER_BEARER_TOKEN', nil)
    return unless bearer_token

    # Due to sensitive settings, the content of tweet can be taken only by API.
    url = 'https://twitter.com/atahuta_/status/1437431869138632705'
    result = Panchira.fetch(url, {twitter: {bearer_token: bearer_token}})

    assert_match 'atahuta', result.title
    assert_match 'atahuta', result.author
    assert_match 'skeb納品しました', result.description
    assert_equal ['R18_35'], result.tags
    assert_equal 'https://pbs.twimg.com/media/E_LInjsVcAEzhyt.jpg', result.image.url
    assert_equal 829, result.image.width
    assert_equal 1200, result.image.height
  end
end
