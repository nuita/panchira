# frozen_string_literal: true

require 'test_helper'

class PixivTest < Minitest::Test 
  def test_fetch_pixiv 
    # This art is not matured content, but look at this cute girl!
    url = 'https://www.pixiv.net/member_illust.php?mode=medium&illust_id=73718144'
    attributes = Panchira.fetch(url)

    assert_match 'んあー・・・', attributes[:title]
    assert_match 'ん？あげませんよ！', attributes[:description]
    assert_equal 'https://pixiv.cat/73718144.jpg', attributes[:image][:url]

    # Fetch the first page if it is manga.
    url = 'https://www.pixiv.net/member_illust.php?mode=medium&illust_id=75871400'
    attributes = Panchira.fetch(url)

    assert_match 'DWU', attributes[:title]
    assert_match '浅瀬', attributes[:description]
    assert_equal 'https://pixiv.cat/75871400-1.jpg', attributes[:image][:url]

    # Look at this new url format.
    url = 'https://www.pixiv.net/artworks/78296385'
    attributes = Panchira.fetch(url)

    assert_match '女子大生セッッ', attributes[:title]
    assert_match 'ノポン人', attributes[:description]
    assert_equal 'https://pixiv.cat/78296385-1.jpg', attributes[:image][:url]
  end
end
