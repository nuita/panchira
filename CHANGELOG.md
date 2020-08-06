# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

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

[1.1.0]: https://github.com/nuita/panchira/releases/tag/v1.1.0
[1.0.0]: https://github.com/nuita/panchira/releases/tag/v1.0.0
[0.3.0]: https://github.com/nuita/panchira/releases/tag/v0.3.0
[0.2.0]: https://github.com/nuita/panchira/releases/tag/v0.2.0
[0.1.1]: https://github.com/nuita/panchira/releases/tag/v0.1.1
[0.1.0]: https://github.com/nuita/panchira/releases/tag/v0.1.0
