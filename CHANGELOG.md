# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## 1.6.0 - 2023-01-05
### Added
- Added support for non-Japanese DLsite URLs.

### Fixed
- Fixed an issue where FANZA resolver don't work due to renewal of the website.
- Fixed an issue where Melonbooks resolver don't work due to renewal of the website.

## 1.5.3 - 2022-06-04
### Fixed
- Fixed an issue where Pixiv resolver can't retrieve image urls for manga.

### Changed
- DLsite resolver now returns descriptions without platform PR sentences.

## 1.5.2 - 2022-03-20
### Fixed
- Fixed an issue where Pixiv resolver can't retrieve not-proxied image scales.

## 1.5.1 - 2022-03-20
### Added
- Pixiv resolver can now fetch image URIs that are not proxied.

## 1.5.0 - 2022-03-01
### Changed
- You can now set options in Panchira::fetch and Resolver's constructors.
- Twitter resolver can now fetch datas from API (requires bearer token).
- Max execution time is now set to 10 seconds.

## 1.4.0 - 2022-01-10
### Added
- Added support for non-Japanese pixiv URLs.

### Fixed
- Fixed an issue where Nijie Resolver failed to fetch image.

### Changed
- Dropped support for Ruby 2.6.

## 1.3.6 - 2021-10-19
### Added
- Added support for Twitter.

### Changed
- Melonbooks Resolver now returns image URI without resizing queries.

## 1.3.5 - 2021-09-01
### Added
- Added support for Pixiv Novel.

### Fixed
- Fixed an issue where Image Resolver missed image scales.

## 1.3.4 - 2021-07-26
### Fixed
- Fixed an issue where Iwara Resolver failed when a description was present.

## 1.3.3 - 2021-07-25
### Added
- Added support for Iwara.

### Fixed
- Fixed an issue where DLsite Resolver was retrieving wrong tags.

## 1.3.2 - 2021-05-23
### Fixed
- Fixed an issue where Fanza Resolver was retrieving incorrect canonical URLs.
- Fixed an issue where Narou Resolver was retrieving wrong descriptions.

### Changed
- Updated dependencies.

## 1.3.1 - 2021-02-17
### Added
- Added support for Fanza Video.

## 1.3.0 - 2021-02-06
### Added
- Added support for multiple authors. PanchiraResult#authors now returns an array of authors.
- PanchiraResult now returns a resolver name used in the process (PanchiraResult#resolver).

### Fixed
- Fixed an issue that fetching DLSite pages with multiple authors were not working.
- Fixed a slight issue in MelonbooksResolver.

## 1.2.0 - 2020-10-31
### Added
- You can now fetch author and circle name in resolvers (Resolver#fetch_author, Resolver#fetch_circle).

### Changed
- Resolver#fetch_title returns the title of the content (not the original title of the page).

## 1.1.1 - 2020-08-09
### Added
- Added support for Fanza Doujin.
- Added support for description in Fanza Book.

### Fixed
- Fixed an issue that fetching image was not working in Fanza Book.

## 1.1.0 - 2020-08-06
### Added
- Added support for Fanza Books.
- Added support for direct links to an image.
- You can now set cookie by overriding Resolver#cookie in individual resolvers.

### Changed
- Resolver::USER_AGENT changed to Resolver#user_agent.

## 1.0.0 - 2020-06-23
### Added
- Added support for tags.

### Fixed
- Fixed some outdated documents.

## 0.3.0 - 2020-06-04
### Added
- You can now register and use your own Resolver with this gem. (see Panchira::Extensions#register)
- Added support for new Twitter UI.

### Changed
- Panchira::fetch now returns an instance of PanchiraResult instead of a hash.
- Changed default User-Agent slightly.

## 0.2.0 - 2020-05-18
### Added
- Added support for Shousetsuka Ni Narou (novel18.syosetu.com).
- Added support for external resolvers.
- Added method Panchira::Resolvers#applicable?.

## 0.1.1 - 2020-05-13
### Fixed
- Fix serious requirement issue and make this gem at least executable.

## 0.1.0 - 2020-05-13 [YANKED]
### Added
- Released Panchira gem. At this time we can parse only 5 websites.
