# frozen_string_literal: true

require 'test_helper'

class IwaraTest < Minitest::Test
  def test_fetch_komiflo
    url = 'https://ecchi.iwara.tv/videos/vqgajhmvpahe1xpgm'
    result = Panchira.fetch(url)

    assert_equal 'Panchira::IwaraResolver', result.resolver
    assert_equal 'https://ecchi.iwara.tv/videos/vqgajhmvpahe1xpgm', result.canonical_url
    assert_equal 'LUVORATORRRRRY!', result.title
    assert_equal 'Nanohana', result.author
    assert_equal 'https://i.iwara.tv/sites/default/files/videos/thumbnails/915803/thumbnail-915803_0005.jpg', result.image.url
    assert_includes result.tags, 'Virtual Youtuber'
  end
end
