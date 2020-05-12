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

  def test_fetch_komiflo_correctly
    url = 'https://komiflo.com/#!/comics/4635/read/page/3'
    attributes = Panchira.fetch(url)

    assert_equal 'https://komiflo.com/comics/4635', attributes[:canonical_url]
    assert_match '晴れ時々露出予報', attributes[:title]
    assert_match 'NAZ', attributes[:description]
    assert_equal 'https://t.komiflo.com/564_mobile_large_3x/contents/cdcfb81ea67a74519b8ad9dea6de8c5d4cec9f9f.jpg', attributes[:image][:url]
  end

  def test_fetch_nijie_correctly
    # Canonical url should normalize mobile url.
    url = 'https://sp.nijie.info/view_popup.php?id=319985'
    attributes = Panchira.fetch(url)

    assert_equal 'https://nijie.info/view.php?id=319985', attributes[:canonical_url]
    assert_match '発情めめめ', attributes[:title]

    # Fetch thumbnail if the hentai is an animated GIF.
    url = 'http://nijie.info/view.php?id=177736'
    attributes = Panchira.fetch(url)

    assert_match '__rs_l160x160', attributes[:image][:url]

    # Picture test for nijie.
    url = 'https://nijie.info/view.php?id=322323'
    attributes = Panchira.fetch(url)

    assert_equal 'https://pic.nijie.net/05/nijie_picture/3965_20190710041444_0.png', attributes[:image][:url]
    assert_equal 1764, attributes[:image][:width]
    assert_equal 1876, attributes[:image][:height]
  end
end


def test_fetch_melonbooks_correctly
  url = 'https://www.melonbooks.co.jp/detail/detail.php?product_id=319663'

  @link = Link.fetch_from(url)
  assert_match 'https://www.melonbooks.co.jp/detail/detail.php?product_id=319663&adult_view=1', @link.url
  assert_match 'めちゃシコごちうさアソート', @link.title
  assert_match 'image=212001143963.jpg', @link.image
  assert_no_match 'c=1', @link.image
  assert_match 'めちゃシコシリーズ', @link.description

  # Page structure in melonbooks changes if there is a review from staff.
  url = 'https://www.melonbooks.co.jp/detail/detail.php?product_id=242938'
  @link = Link.fetch_from(url)

  assert_match 'ぬめぬめ', @link.title
  assert_match '諏訪子様にショタがいじめられる話です。', @link.description #かわいそう…
end
