# Typogruby

[![Build Status](https://secure.travis-ci.org/avdgaag/typogruby.png?branch=master)](http://travis-ci.org/avdgaag/typogruby)

Helps you improve your web typograpbhy with some standard text filters.

This project is based on Django's Typogrify, so the best introduction to read would be [Jeff Croft's][1].

I created this gem to easily share these text filters in some tiny Ruby projects, including [a TextMate bundle][5]. For production code I recommend checking out the originals first.

## General Usage

First, install the Ruby gem:

    $ gem install typogruby

Then require the library to get started:

```ruby
require 'typogruby'
Typogruby.improve('Hello, world!')
```

Or, you can include the library in a helper or something:

```ruby
require 'typogruby'
include Typogruby
improve('Hello, world!')
```

See the [full API documentation][4] for more information. You could also use [this Textmate Bundle][5].

## From the command line

You can also use typogruby directly from the command line:

    typogruby MY_FILE

This will output the contents of your file with all filters applied. Use `typogruby -h` for more information and options.

## References

* Based on [typography-helper][2]
* ...and on [Typogrify][3]
* [Description of typogrify][1]

## Changelog

See HISTORY.md for the complete changelog.

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Credits

By Arjan van der Gaag ([avdgaag @ github][6]) based on the hard work of lots of others. See LICENSE for license details (same as Ruby).

This gem includes contributions by:

* Justin Hileman
* Peter Aronoff

[1]: http://jeffcroft.com/blog/2007/may/29/typogrify-easily-produce-web-typography-doesnt-suc/
[2]: http://github.com/hunter/typography-helper
[3]: http://code.google.com/p/typogrify
[4]: http://avdgaag.github.com/typogruby
[5]: http://github.com/avdgaag/Typography-tmbundle
[6]: http://github.com/avdgaag
