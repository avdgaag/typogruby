# typogrify

Helps you improve your web typograpbhy with some standard text filters.

This project is based on Django's Typogrify, so the best introduction to read would be [Jeff Croft's][1].

I created this gem to easily share these text filters in some tiny Ruby projects, including a TextMate bundle. For production code I recommend checking out the originals first.

## General Usage

First, install the Ruby gem:

    $ gem install typogrify

Then require the library to get started:

    require 'typogrify'
    Typogrify.improve('Hello, world!')

Or, you can include the library in a helper or something:

    require 'typogrify'
    include Typogrify
    improve('Hello, world!')

## References

* Based on [typography-helper][2]
* ...and on [Typogrify][3]
* [Description of typogrify][1]

[1]: http://jeffcroft.com/blog/2007/may/29/typogrify-easily-produce-web-typography-doesnt-suc/
[2]: http://github.com/hunter/typography-helper
[3]: http://code.google.com/p/typogrify

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## License

Copyright (c) 2010 Arjan van der Gaag

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
