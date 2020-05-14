# frozen_string_literal: true

require 'test_helper'

class NarouTest < Minitest::Test
  def test_fetch_narou
    url = 'https://novel18.syosetu.com/n9235cz/116/'
    attributes = Panchira.fetch(url)

    assert_match '知らないうちに催眠ハーレム生徒会', attributes[:title]
    assert_match '新型コロナウイルス', attributes[:title]

    url = 'https://novel18.syosetu.com/n2468et/'
    attributes = Panchira.fetch(url)

    assert_match '妹', attributes[:title]
    assert_match 'ある日、エロゲをプレイしていたところを妹に見られた。', attributes[:description]
  end
end
