# frozen_string_literal: true

require 'test_helper'

class DLSiteTest < Minitest::Test
  def test_fetch_dlsite
    # Doujin Onsei with circle and without author.
    url = 'https://www.dlsite.com/maniax-touch/dlaf/=/t/p/link/work/aid/miuuu/id/RJ255695.html'
    result = Panchira.fetch(url)

    assert_match '性欲処理される生活。', result.title
    assert_match '事務的な双子メイドが、両耳から囁きながら、ご主人様のおちんぽのお世話をしてくれます♪', result.description
    assert_match '防鯖潤滑剤', result.circle
    assert_nil result.author
    assert_equal 'https://img.dlsite.jp/modpub/images2/work/doujin/RJ256000/RJ255695_img_main.jpg', result.image.url
    assert_includes result.tags, '淫語'

    # Shogyo with author and without circle. I personally love this book.
    url = 'https://www.dlsite.com/books/work/=/product_id/BJ066976.html'
    result = Panchira.fetch(url)

    assert_match 'ミルク*クラウン', result.title
    assert_match '全ドM男子&ドS女子必携!', result.description
    assert_match '豆', result.author
    assert_nil result.circle
    assert_includes result.tags, 'SM'
  end
end
