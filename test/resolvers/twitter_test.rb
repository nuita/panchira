# frozen_string_literal: true

require 'test_helper'

class TwitterTest < Minitest::Test
  def test_fetch_twitter
    url = 'https://twitter.com/bot_erection/status/1412029253906886657'
    result = Panchira.fetch(url)

    assert_match '勃起タイムbot', result.title
    assert_match '君は中学生なのになかなかの勃起サイズをしているね？', result.description
    assert_match 'https://pbs.twimg.com/media', result.image.url
  end
end
