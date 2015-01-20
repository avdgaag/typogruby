# Changelog

## 1.0.18

* Added `<title>` to list of excluded tags
* Switched to Minitest for unit testing

## 1.0.17

* Allow ampersands in capitalised words (thanks Paul Robert Lloyd)

## 1.0.16

* Added textarea to list of ignored elements (thanks Juan Antonio Navarro Pérez)
* Added Haml filter

## 1.0.15

* Added head to list of ignored elements (thanks Peter Aronoff)

## 1.0.14

* Bugfix: ignore multi-line HTML attributes in widont filter

## 1.0.13

* Be smart about periods in abbreviations. Capitalise LA, L.A. and L.A, but not L. or L. A. (by Brad Weslake)

## 1.0.12

* Fixed aruba deprecation warnings
* Ensure duplicate sensitive tags are properly rendered (thanks Justin Hileman)
* Removed obsolete tag-ignoring clauses from regexes

## 1.0.11

* Excluded more typography-sensitive tags from filtering (thanks Justin Hileman)

## 1.0.10

* Decoupled jeweler, which is no longer a dependency.
* Various minor documentation issues and internal refactorings

## 1.0.9

* Bugfix: ignore caps in HTML attribute values

## 1.0.8

* Allow command-line output to disk via -o option
* command-line tool reads both files and STDIN, enabling piping of content
* added filter to replace special characters with HTML entities
* better tests for the command-line tool with cucumber and aruba

## 1.0.7

* Improved Ruby 1.9 compatibility
* Improved documentation
* Merged test helper and test case

## 1.0.6

* Bugfix: ignore inline javascript

## 1.0.5

* Manage gem dependencies using Bundler

## 1.0.4

* Bugfix: no longer regard combination of digits and periods as caps.
* Bugfix: do not add consecutive non-breaking spaces to prevent widows

## 1.0.3

* Bugfix: caps also ignores unequal but same excepted tags
* Feature: added command-line program
* Improved documentation

## 1.0.2

* Bugfix: initial_quotes also wraps named HTML entities
* Bugfix: caps no longer wraps consecutive numbers

## 1.0

* First release
