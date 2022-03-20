[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Ruby](https://github.com/nuita/panchira/workflows/Ruby/badge.svg)
[![Gem Version](https://badge.fury.io/rb/panchira.svg)](https://badge.fury.io/rb/panchira)

# Panchira

Due to some legal or ethical issues, most hentai and NSFW platforms don't clarify their content on meta tags. As a result, most hentai platforms are rendered poorly on the card previews on social media.

To solve this issue, Panchira is made to parse correct and uncensored metadata from such web platforms (at this time we cover **DLSite, Komiflo, Melonbooks, Nijie, Pixiv, Shousetsuka ni narou, Fanza, Iwara and Twitter**).

If you need card previews of hentai on your web application, but can't get them with simply parsing metatags, then it is time for Panchira.

This gem is derived from the [Nuita](https://github.com/nuita/nuita) project.

## Caution

**Please use this gem with appropriate censoring and age-restricting. Never violate local laws and copyrights.**

If you are running one of the websites we cover and feel negative about this gem, please contact the community or the author([@kypkyp](https://github.com/kypkyp)). 

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

=> #<Panchira::PanchiraResult:0x00007ff15890e948 @canonical_url="https://pixiv.net/member_illust.php?mode=medium&illust_id=61711172", @title="すずしい顔で締め切りを破る幸子", @description="(UTF16の)Pietで実行すると「すずしい」と出力する幸子(5色+白Pietカラーゴルフ)。解説記事は http://chy72.hatenablog.com/entry/2016/12/24/1", @image=#<Panchira::PanchiraImage:0x00007ff15931fc48 @url="https://pixiv.cat/61711172.jpg", @width=810, @height=500>, @tags=["輿水幸子", "Piet", "プログラミング"], @authors=["むらため"], @circle=nil, @resolver="Panchira::PixivResolver">
```

In most situation you would call `Panchira#fetch`. It is a singular method that takes a URI and returns an instance of `PanchiraResult`, which is a simple class that stores the website's information, such as title, description and so on.

Panchira has a special treatment for each website. `Resolver` classes are where those treatments take place, and you can use your own `Resolver` classes by registering it to Panchira. See `Panchira::Extensions` documentation in source code for further details.

### About Twitter API

Due to a recent change in Twitter, it's getting really hard to fetch tweet data by scraping. To solve this problem, Panchira can now use Twitter official API.

To use Twitter API instead of normal scraping, please set Twitter's bearer token as an option to `Panchira::fetch`. If you don't set token, Panchira will just fall back to simple scraping. 

```
> Panchira.fetch("https://twitter.com/example/status/1234567890", options: {twitter: {bearer_token: 'ABC...123'}})
```

### About Pixiv proxy

By default, Panchira returns a link to [Pixiv.cat](https://pixiv.cat/) as a image URI, but you can change this behavior by setting `fetch_raw_image_url` as an option. To access not-proxied URI, pximg.net, you have to set Referer as `https://app-api.pixiv.net/` in HTTP request header.

```
> Panchira.fetch("https://pixiv.net/artworks/12345678", options: {pixiv: {fetch_raw_image_url: true}})
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nuita/panchira.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
