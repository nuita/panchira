# frozen_string_literal: true

require 'test_helper'

class NarouTest < Minitest::Test
  def test_fetch_novel18_story
    url = 'https://novel18.syosetu.com/n9235cz/116/'
    result = Panchira.fetch(url)

    assert_match '知らないうちに催眠ハーレム生徒会', result.title
    assert_match '新型コロナウイルス', result.title
    assert_equal '踏台昇降運動', result.author
    assert_includes result.tags, 'ハーレム'
  end

  def test_fetch_novel18
    url = 'https://novel18.syosetu.com/n7016er/'
    result = Panchira.fetch(url)

    assert_match 'TS（？）少女が無意識に常時スキル「魅了」でファンタジー世界を歩くお話（仮）', result.title
    assert_match '突然ファンタジー世界に降り立った主人公は自分がなんとなく男であり女ではなかったという感覚だけを残して記憶を失っていた。', result.description
    assert_equal 'KawaHaru', result.author
    assert_includes result.tags, 'TS'
  end

  def test_fetch_ncode
    url = 'https://ncode.syosetu.com/n6383el/'
    result = Panchira.fetch(url)

    assert_match '太宰治、異世界転生して勇者になる', result.title
    assert_equal '高橋弘', result.author
    assert_includes result.tags, '太宰治'
  end

  def test_fetch_ncode_story
    # R-15作品やガールズラブ作品はキーワードのところにNBSPが含まれている。
    url = 'https://ncode.syosetu.com/n6711eo/1/'
    result = Panchira.fetch(url)

    assert_match 'スコップ無双', result.title
    assert_match 'プロローグ', result.title
    assert_equal 'ZAP', result.author
    assert_includes result.tags, '主人公最強'
  end
end
