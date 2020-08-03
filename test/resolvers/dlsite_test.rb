# frozen_string_literal: true

require 'test_helper'

class DLSiteTest < Minitest::Test
  def test_fetch_dlsite
    url = 'https://www.dlsite.com/maniax-touch/dlaf/=/t/p/link/work/aid/miuuu/id/RJ255695.html'
    result = Panchira.fetch(url)

    assert_match '性欲処理される生活。', result.title
    assert_match '事務的な双子メイドが、両耳から囁きながら、ご主人様のおちんぽのお世話をしてくれます♪', result.description
    assert_equal 'https://img.dlsite.jp/modpub/images2/work/doujin/RJ256000/RJ255695_img_main.jpg', result.image.url
    assert result.tags.include?('淫語')
  end
end
