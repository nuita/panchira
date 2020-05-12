# frozen_string_literal: true

require 'test_helper'

class PanchiraTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Panchira::VERSION
  end

  def test_fetch_data_generally
    # hikakinTV
    url = 'https://www.youtube.com/user/HikakinTV'
    attributes = Panchira.fetch(url)

    assert_equal 'HikakinTV', attributes[:title]
    assert_match 'ヒカキン', attributes[:description]
    assert_equal %i[url width height], attributes[:image].keys

    # please follow me on Instagram!
    url = 'https://www.instagram.com/_kypkyp/'
    attributes = Panchira.fetch(url)
    assert_match 'Instagram', attributes[:title]
    assert_match 'kypkyp', attributes[:description]
  end

  def test_fetch_canonical_url
    url = 'https://blog.hubspot.jp/canonical-url?hogehoge=1'
    attributes = Panchira.fetch(url)
    assert_equal 'https://blog.hubspot.jp/canonical-url', attributes[:canonical_url]

    # it's ok if you don't have canonical url
    url = 'https://example.com/'
    attributes = Panchira.fetch(url)
    assert_equal 'https://example.com/', attributes[:canonical_url]
  end

  def test_fetch_dlsite_correctly
    url = 'https://www.dlsite.com/maniax-touch/dlaf/=/t/p/link/work/aid/miuuu/id/RJ255695.html'
    attributes = Panchira.fetch(url)

    assert_match '性欲処理される生活。', attributes[:title]
    assert_match '事務的な双子メイドが、両耳から囁きながら、ご主人様のおちんぽのお世話をしてくれます♪', attributes[:description]
    assert_equal 'https://img.dlsite.jp/modpub/images2/work/doujin/RJ256000/RJ255695_img_main.jpg', attributes[:image][:url]
  end

end
