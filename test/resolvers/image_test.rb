# frozen_string_literal: true

require 'test_helper'

class ImageTest < Minitest::Test
  def test_fetch_jpeg
    url = 'http://dokidokivisual.com/img/top/main_img.jpg'
    result = Panchira.fetch(url)

    assert_match url, result.image.url
  end
  def test_fetch_png
    url = 'http://dokidokivisual.com/img/top/anime_banner_doubiju_170731.png'
    result = Panchira.fetch(url)

    assert_match url, result.image.url
  end
  def test_fetch_gif
    url = 'http://dokidokivisual.com/img/common/global_magazine_menu03.gif'
    result = Panchira.fetch(url)

    assert_match url, result.image.url
  end
end
