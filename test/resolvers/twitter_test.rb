# frozen_string_literal: true

require 'test_helper'

class TwitterTest < Minitest::Test
  def test_fetch_twitter
    url = 'https://twitter.com/mirakuru_rodeo/status/1266016566769926144'
    result = Panchira.fetch(url)

    assert_match 'みらくるる', result.title
    assert_match '2巻発売中', result.description
    assert_match 'https://pbs.twimg.com/media', result.image.url
  end
end
