[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://travis-ci.org/nuita/panchira.svg?branch=master)](https://travis-ci.org/nuita/panchira.svg?branch=master)
[![Gem Version](https://badge.fury.io/rb/panchira.svg)](https://badge.fury.io/rb/panchira)

# Panchira

Due to some legal or ethical issues, most hentai and NSFW platforms don't clarify their content on meta tags. As a result, most hentai platforms are rendered poorly on the card previews on social media.

To solve this issue, Panchira is made to parse correct and uncensored metadata from such web platforms (at this time we cover **DLSite, Komiflo, Melonbooks, Nijie and Pixiv**).

If you need card previews of hentai on your web application, but can't get them with simply parsing metatags, then it is time for Panchira.

This gem is derived from the [Nuita](https://github.com/nuita/nuita) project.

## Caution

**Please use this gem with appropriate censoring and age-restricting. Never violate local laws and copyrights.**

If you are running one of the websites we cover and feel negative about it, please contact the community or the author([@kypkyp](https://github.com/kypkyp)). 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'panchira'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install panchira

## Usage

```
> Panchira.fetch("https://www.pixiv.net/artworks/61711172")

=> {:canonical_url=>"https://pixiv.net/member_illust.php?mode=medium&illust_id=61711172", :title=>"#輿水幸子 すずしい顔で締め切りを破る幸子 - むらためのイラスト - pixiv", :description=>"(UTF16の)Pietで実行すると「すずしい」と出力する幸子(5色+白Pietカラーゴルフ)。解説記事は http://chy72.hatenablog.com/entry/2016/12/24/1", :image=>{:url=>"https://pixiv.cat/61711172.jpg", :width=>810, :height=>500}}
```

Panchira is in beta at this time and doesn't have stable API documentation yet.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nuita/panchira.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
