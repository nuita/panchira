# frozen_string_literal: true

require 'test_helper'

class DLSiteTest < Minitest::Test
  def test_fetch_dlsite
    # Doujin Onsei with circle and without author.
    url = 'https://www.dlsite.com/maniax-touch/dlaf/=/t/p/link/work/aid/miuuu/id/RJ255695.html'
    result = Panchira.fetch(url)

    assert_equal 'Panchira::DlsiteResolver', result.resolver
    assert_match '性欲処理される生活。', result.title
    assert_match '事務的な双子メイドが、両耳から囁きながら、ご主人様のおちんぽのお世話をしてくれます♪', result.description
    refute result.description.match?('DLsite')
    assert_match '防鯖潤滑剤', result.circle
    assert_nil result.author
    assert_equal 'https://img.dlsite.jp/modpub/images2/work/doujin/RJ256000/RJ255695_img_main.jpg', result.image.url
    assert_includes result.tags, '淫語'

    # Commercial comic with author and without circle.
    url = 'https://dlsite.jp/bowot/BJ101997/?utm_content=BJ101997'
    result = Panchira.fetch(url)

    assert_equal '僕は管理・管理・管理されている', result.title
    assert_match '射精管理', result.description
    assert_equal '紅唯まと', result.author
    assert_nil result.circle
    assert_includes result.tags, '男性受け'
  end

  def test_dlsite_with_other_locales
    # Can retrieve url with other locales.
    url = 'https://www.dlsite.com/maniax/work/=/product_id/RJ176036.html/?locale=ko_KR'
    result = Panchira.fetch(url)

    assert_equal '悪の女首領と童貞構成員', result.title
    assert_equal 'DT工房', result.circle
    assert_includes result.tags, '断面図'
  end

  def test_dlsite_with_multiple_authors
    url = 'https://www.dlsite.com/books/work/=/product_id/BJ246254.html'
    result = Panchira.fetch(url)

    assert_includes result.author, 'たかみち'
    assert_includes result.author, '猫男爵'
    assert_includes result.author, 'ぼうえん'
  end
end
