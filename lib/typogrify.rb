require 'rubypants'

# A collection of simple helpers for improving web
# typograhy. Based on TypographyHelper by Luke Hartman and Typogrify.
#
# @see http://github.com/hunter/typography-helper
# @see http://code.google.com/p/typogrify
# @author Arjan van der Gaag <arjan.vandergaag@gmail.com>
module Typogrify

  # Get the current gem version number
  # @return [String]
  def version
    File.read(File.join(File.dirname(__FILE__), *%w{.. VERSION}))
  end

  # Applies smartypants to a given piece of text
  #
  # @example
  # smartypants('The "Green" man')
  # # => 'The &#8220;Green&#8221; man'
  #
  # @param [String] text input text
  # @return [String] input text with smartypants applied
  def smartypants(text)
    ::RubyPants.new(text).to_html
  end

  # converts a & surrounded by optional whitespace or a non-breaking space
  # to the HTML entity and surrounds it in a span with a styled class
  #
  # @example
  # amp('One & two')
  # # => 'One <span class="amp">&amp;</span> two'
  # amp('One &amp; two')
  # # => 'One <span class="amp">&amp;</span> two'
  # amp('One &#38; two')
  # # => 'One <span class="amp">&amp;</span> two'
  # amp('One&nbsp;&amp;&nbsp;two')
  # # => 'One&nbsp;<span class="amp">&amp;</span>&nbsp;two'
  #
  # @example It won't mess up & that are already wrapped, in entities or URLs
  #
  # amp('One <span class="amp">&amp;</span> two')
  # # => 'One <span class="amp">&amp;</span> two'
  # amp('&ldquo;this&rdquo; & <a href="/?that&amp;test">that</a>')
  # # => '&ldquo;this&rdquo; <span class="amp">&amp;</span> <a href="/?that&amp;test">that</a>'
  #
  # @example It should ignore standalone amps that are in attributes
  # amp('<link href="xyz.html" title="One & Two">xyz</link>')
  # # => '<link href="xyz.html" title="One & Two">xyz</link>'
  #
  # @param [String] text input text
  # @return [String] input text with ampersands wrapped
  def amp(text)
    # $1 is an excluded HTML tag, $2 is the part before the caps and $3 is the amp match
    text.gsub(/<(code|pre).+?<\/\1>|(\s|&nbsp;)&(?:amp;|#38;)?(\s|&nbsp;)/) {|str|
    $1 ? str : $2 + '<span class="amp">&amp;</span>' + $3 }.gsub(/(\w+)="(.*?)<span class="amp">&amp;<\/span>(.*?)"/, '\1="\2&amp;\3"')
  end

  # replaces space(s) before the last word (or tag before the last word)
  # before an optional closing element (<tt>a</tt>, <tt>em</tt>,
  # <tt>span</tt>, strong) before a closing tag (<tt>p</tt>, <tt>h[1-6]</tt>,
  # <tt>li</tt>, <tt>dt</tt>, <tt>dd</tt>) or the end of the string
  #
  # @example
  # > widont('A very simple test')
  # # => 'A very simple&nbsp;test'
  #
  # @example Single word items shouldn't be changed
  # widont('Test')
  # # => 'Test'
  # widont(' Test')
  # # => ' Test'
  # widont('<ul><li>Test</p></li><ul>')
  # # => '<ul><li>Test</p></li><ul>'
  # widont('<ul><li> Test</p></li><ul>')
  # # => '<ul><li> Test</p></li><ul>'
  #
  # @example Nested tags
  # widont('<p>In a couple of paragraphs</p><p>paragraph two</p>')
  # # => '<p>In a couple of&nbsp;paragraphs</p><p>paragraph&nbsp;two</p>'
  # widont('<h1><a href="#">In a link inside a heading</i> </a></h1>')
  # # => '<h1><a href="#">In a link inside a&nbsp;heading</i> </a></h1>'
  # widont('<h1><a href="#">In a link</a> followed by other text</h1>')
  # # => '<h1><a href="#">In a link</a> followed by other&nbsp;text</h1>'
  #
  # @example Empty HTMLs shouldn't error
  # widont('<h1><a href="#"></a></h1>')
  # # => '<h1><a href="#"></a></h1>'
  #
  # @example Excluded tags
  # widont('<div>Divs get no love!</div>')
  # # => '<div>Divs get no love!</div>'
  # widont('<pre>Neither do PREs</pre>')
  # # => '<pre>Neither do PREs</pre>'
  # widont('<div><p>But divs with paragraphs do!</p></div>')
  # # => '<div><p>But divs with paragraphs&nbsp;do!</p></div>'
  #
  # @see http://mucur.name/posts/widon-t-and-smartypants-helpers-for-rails
  # @see http://shauninman.com/archive/2006/08/22/widont_wordpress_plugin
  # @param [String] text input text
  # @return [String] input text with non-breaking spaces inserted
  def widont(text)
    text.gsub(%r{
      ((?:</?(?:a|em|span|strong|i|b)[^>]*>)|[^<>\s]) # must be proceeded by an approved inline opening or closing tag or a nontag/nonspace
      \s+                                             # the space to replace
      ([^<>\s]+                                       # must be flollowed by non-tag non-space characters
      \s*                                             # optional white space!
      (</(a|em|span|strong|i|b)>\s*)*                 # optional closing inline tags with optional white space after each
      ((</(p|h[1-6]|li|dt|dd)>)|$))                   # end with a closing p, h1-6, li or the end of the string
    }x, '\1&nbsp;\2')
  end

  # surrounds two or more consecutive captial letters, perhaps with interspersed digits and periods
  # in a span with a styled class
  #
  # @example
  # caps("A message from KU")
  # # => 'A message from <span class="caps">KU</span>'
  #
  # @example Allows digits
  # caps("A message from 2KU2 with digits")
  # # => 'A message from <span class="caps">2KU2</span> with digits'
  #
  # @example All caps with with apostrophes in them shouldn't break. Only handles dump apostrophes though.
  # caps("JIMMY'S")
  # # => '<span class="caps">JIMMY\\'S</span>'
  # caps("<i>D.O.T.</i>HE34T<b>RFID</b>")
  # # => '<i><span class="caps">D.O.T.</span></i><span class="caps">HE34T</span><b><span class="caps">RFID</span></b>'
  #
  # @param [String] text input text
  # @return [String] input text with caps wrapped
  def caps(text)
    # $1 is an excluded HTML tag, $2 is the part before the caps and $3 is the caps match
    text.gsub(/<(code|pre).+?<\/\1>|(\s|&nbsp;|^|'|"|>)([A-Z\d][A-Z\d\.']{1,})(?!\w)/) {|str|
    $1 ? str : $2 + '<span class="caps">' + $3 + '</span>' }
  end

  # encloses initial single or double quote, or their entities
  # (optionally preceeded by a block element and perhaps an inline element)
  # with a span that can be styled
  #
  # @example
  # initial_quotes('"With primes"')
  # # => '<span class="dquo">"</span>With primes"'
  # initial_quotes("'With single primes'")
  # # => '<span class="quo">\\'</span>With single primes\\''
  #
  # @example With primes and links
  # initial_quotes('<a href="#">"With primes and a link"</a>')
  # # => '<a href="#"><span class="dquo">"</span>With primes and a link"</a>'
  #
  # @example with Smartypants-quotes
  # initial_quotes('&#8220;With smartypanted quotes&#8221;')
  # # => '<span class="dquo">&#8220;</span>With smartypanted quotes&#8221;'
  #
  # @param [String] text input text
  # @return [String] input text with initial quotes wrapped
  def initial_quotes(text)
    # $1 is the initial part of the string, $2 is the quote or entitity, and $3 is the double quote
    text.gsub(/((?:<(?:h[1-6]|p|li|dt|dd)[^>]*>|^)\s*(?:<(?:a|em|strong|span)[^>]*>)?)('|&#8216;|("|&#8220;))/) {$1 + "<span class=\"#{'d' if $3}quo\">#{$2}</span>"}
  end

  # main function to do all the functions from the method
  # @param [String] text input text
  # @return [String] input text with all filters applied
  def improve(text)
    initial_quotes(caps(smartypants(widont(amp(text)))))
  end

  extend self
end