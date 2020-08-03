# frozen_string_literal: true

require 'test_helper'

class NarouTest < Minitest::Test
  def test_fetch_novel18_story
    url = 'https://novel18.syosetu.com/n9235cz/116/'
    result = Panchira.fetch(url)

    assert_match '知らないうちに催眠ハーレム生徒会', result.title
    assert_match '新型コロナウイルス', result.title
    assert result.tags.include?('ハーレム')
  end

  def test_fetch_novel18
    url = 'https://novel18.syosetu.com/n2468et/'
    result = Panchira.fetch(url)

    assert_match '妹', result.title
    assert_match 'ある日、エロゲをプレイしていたところを妹に見られた。', result.description
    assert result.tags.include?('オナニー')
  end

  def test_fetch_ncode
    url = 'https://ncode.syosetu.com/n6383el/'
    result = Panchira.fetch(url)

    assert_match '太宰治、異世界転生して勇者になる', result.title
    assert result.tags.include?('太宰治')
  end

  def test_fetch_ncode_story
    # R-15作品やガールズラブ作品はキーワードのところにNBSPが含まれている。
    url = 'https://ncode.syosetu.com/n6711eo/1/'
    result = Panchira.fetch(url)

    assert_match 'スコップ無双', result.title
    assert_match 'プロローグ', result.title
    assert result.tags.include?('主人公最強')
  end
end
