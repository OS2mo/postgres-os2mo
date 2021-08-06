# Changelog
## Revision `12` 2021-05-31

* Rework from postgres container to init container

## Revision `11` 2020-12-03

* Automatically update password on database on startup if changed

## Revision `10` 2020-03-05
* Change CI docker builder to kaniko
* Add missing changelog for `9.6.15-3`
* Change version numbering from `<pg_version>-<revision>` to
  `<revision>-<pg_version>`
* Add multiple parallel released versions of postgres and remove support for
  `:latest`-tags
* Remove unused `:dev`-tags builds

## Rev 4-9 skipped
For correct sorting with old version numbers.

## `9.6.15-3` 2019-12-19
* Add changelog
* Documentation fixup

## `9.6.15-2` 2019-11-05
* Split image into a production and a test image
* Add pgTAP to test image

## `9.6.15-1` 2019-11-05
* First release
