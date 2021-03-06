## 1.9.1

* Fixed `tslint` with `--type-check`

## 1.9.0

* Switch to `alpine:3.7`
* Remove `bash`, `sudo`
* Rewrite posix like wrappers

## 1.8.1

* Refactor `pylint`, `tslint` wrappers
* Turn off pseudo-tty for `docker`, `docker-machine`, `browser-remote` wrappers

## 1.8.0

* Literate configuration with `init.org`
* Add `BRANCH` and `HEAD_FORCE` variables
* Remove `--repository` edge

## 1.7.0

* Remove `global`

## 1.6.1

* Add `pylint` wrapper

## 1.6.0

* Remove `nodejs-npm`
* Add tty to wrapper docker for `exec`
* Add `tslint` wrapper
* Add `node` wrapper

## 1.5.3

* Remove directives `ENV` and `WORKDIR` from image

## 1.5.2

* Based clean alpine image
* Add `rubocop` wrapper

## 1.5.1

* First initialize `REPOSITORY`
* Delete `REPOSITORY` source from image
* Minimize docker build context
