# frozen_string_literal: true

require 'test_helper'

class IwaraTest < Minitest::Test
  def test_fetch_iwara
    url = 'https://ecchi.iwara.tv/videos/vqgajhmvpahe1xpgm'
    result = Panchira.fetch(url)

    assert_equal 'Panchira::IwaraResolver', result.resolver
    assert_equal 'https://ecchi.iwara.tv/videos/vqgajhmvpahe1xpgm', result.canonical_url
    assert_equal 'LUVORATORRRRRY!', result.title
    assert_equal 'Nanohana', result.author
    assert_equal 'https://i.iwara.tv/sites/default/files/videos/thumbnails/915803/thumbnail-915803_0005.jpg', result.image.url
    assert_includes result.tags, 'Virtual Youtuber'
    assert_nil result.description
  end

  def test_fetch_iwara_with_desc
    url = 'https://ecchi.iwara.tv/videos/3do1kceoeji4azl5a'
    result = Panchira.fetch(url)

    assert_equal 'Panchira::IwaraResolver', result.resolver
    assert_equal 'https://ecchi.iwara.tv/videos/3do1kceoeji4azl5a', result.canonical_url
    assert_equal '北上〇葉ちゃんのおっぱいを楽しむふっきれた！', result.title
    assert_equal 'いぬ納豆', result.author
    assert_equal 'https://i.iwara.tv/sites/default/files/videos/thumbnails/1319221/thumbnail-1319221_0012.jpg', result.image.url
    assert_includes result.tags, 'Uncategorized'
    assert_includes result.description, 'youtubeに規制されまくって怒りがたまったので北〇双葉ちゃんに脱いでもらいました'
  end
end
