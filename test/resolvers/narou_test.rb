# frozen_string_literal: true

require 'test_helper'

class NarouTest < Minitest::Test
  def test_fetch_novel18_story
    url = 'https://novel18.syosetu.com/n9235cz/116/'
    result = Panchira.fetch(url)

    assert_match '知らないうちに催眠ハーレム生徒会', result.title
    assert_match '新型コロナウイルス', result.title
    assert_equal %w(女子高生 女子中学生 学園 常識改変 催眠 主人公以外が能力者 現代/現代日本 羞恥 依存 面白い 青春 ハーレム 女の子が重い).sort, result.tags.sort
  end

  def test_fetch_novel18
    url = 'https://novel18.syosetu.com/n2468et/'
    result = Panchira.fetch(url)

    assert_match '妹', result.title
    assert_match 'ある日、エロゲをプレイしていたところを妹に見られた。', result.description
    assert_equal %w(現代 男主人公 兄妹 口内射精 オナニー 学生 日常 微　レ　ズ 実質処女の非処女 近親相姦 射精管理 純愛 ハッピーエンド イチャラブ 全感想返信).sort, result.tags.sort
  end
end
