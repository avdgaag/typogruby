---
layout: default
title: Typogruby
tagline: improve your web typography with a simple Ruby gem
nav:
  - url: http://avdgaag.github.com/typogruby
    label: Homepage
  - url: http://github.com/avdgaag/typogruby/issues
    label: Issues
  - url: http://github.com/avdgaag/typogruby
    label: Source
  - url: docs
    label: Docs
---
Typogruby can apply a set of text filters to your HTML documents to make your text look better. It is based on [Django’s typogrify][typogrify].
{: .leader }

## Quick demonstration

    "Typogruby makes HTML look smarter & better, don't you think?"

is turned into:

{% highlight html %}
<span class="dquo">&ldquo;</span>Typogruby makes
<span class="caps">HTML</span> look smarter
<span class="amp">&amp;</span> better,
don&rsquo;t you&nbsp;think?&rdquo;
{% endhighlight %}

Compare the difference, given some appropriate styling:

<div id="examples">
    <p class="example1">"Typogruby makes HTML look smarter & better, don't you think?"</p>
    <p class="example2"><span class="dquo">&#8220;</span>Typogruby makes <span class="caps">HTML</span> look smarter <span class="amp">&amp;</span> better, don&#8217;t you&nbsp;think?&#8221;</p>
</div>

## Quick start guide

### Installation

Typogruby is a Ruby gem and as such requires Ruby installed on your system. Mac OS X and *nix systems usually come with Ruby installed by default.

To install the gem, open a terminal window and run:

{% highlight sh %}
gem install typogruby
{% endhighlight %}

### Usage

You can now use typogruby in two ways. Either apply it to a file **in the terminal**:

{% highlight sh %}
typogruby index.html
{% endhighlight %}

Type `typogruby -h` for more information. Second, you can use it **from a Ruby script**:

{% highlight ruby %}
require 'typogruby'
puts Typogruby.improve('Hello, world!')
{% endhighlight %}

## Included filters

* Rubypants is used for nice special characters, such as quotes and dashes
* A port of [Shaun Inman’s widon’t][widont] is used to prevent widows (using an `&nbsp;` to prevent a single word on a new line).
* All consecutive capital letters are wrapped in `span.caps`
* All quotes at the start of a line are wrapped in `span.dquo`
* All ampersands (&amp;) are wrapped in `span.amp`
* Replace special characters with HTML entities (lifted from TextMate HTML&nbsp;bundle)

## Credits

* **Author**: Arjan van der Gaag (<arjan@arjanvandergaag.nl>)
* **License**: MIT License (same as Ruby)

## More information

You can read more usage instructions in the [API documentation][docs]. Also check out the [license][] and [changelog][]. You can report any bugs in [the Github issue tracker][issues].

[typogrify]: http://code.google.com/p/typogrify/ "Read more about the original python project typogrify"
[widont]:    http://www.shauninman.com/archive/2006/08/22/widont_wordpress_plugin "Read more about Shaun's original script"
[docs]:      docs "Browse the documentation"
[license]:   http://github.com/avdgaag/typogruby/raw/master/LICENSE "Read the MIT license"
[changelog]: http://github.com/avdgaag/typogruby/blob/master/HISTORY.md "Read the changelog"
[issues]:    http://github.com/avdgaag/typogruby/issues "Go to the Github issue tracker to report bugs"
