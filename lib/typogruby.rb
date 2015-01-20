# -*- encoding: utf-8 -*-

require 'rubypants'
require 'digest/md5'
$KCODE = 'U' if RUBY_VERSION < '1.9.0'

# A collection of simple helpers for improving web
# typograhy. Based on TypographyHelper by Luke Hartman and Typogrify.
#
# @example Using all filters
#   require 'typogruby'
#   Typogruby.improve('my text')
#
# @example Using a single filter
#   Typogruby.initial_quotes('my text')
#
# @see http://github.com/hunter/typography-helper
# @see http://code.google.com/p/typogrify
# @author Arjan van der Gaag <arjan.vandergaag@gmail.com>
module Typogruby

  # Applies smartypants to a given piece of text
  #
  # @example
  #   smartypants('The "Green" man')
  #   # => 'The &#8220;Green&#8221; man'
  #
  # @see https://rubygems.org/gems/rubypants
  # @param [String] text input text
  # @return [String] input text with smartypants applied
  def smartypants(text)
    ::RubyPants.new(text).to_html
  end

  # converts a & surrounded by optional whitespace or a non-breaking space
  # to the HTML entity and surrounds it in a span with a styled class.
  #
  # @example
  #   amp('One & two')
  #   # => 'One <span class="amp">&amp;</span> two'
  #   amp('One &amp; two')
  #   # => 'One <span class="amp">&amp;</span> two'
  #   amp('One &#38; two')
  #   # => 'One <span class="amp">&amp;</span> two'
  #   amp('One&nbsp;&amp;&nbsp;two')
  #   # => 'One&nbsp;<span class="amp">&amp;</span>&nbsp;two'
  #
  # @example It won't mess up & that are already wrapped, in entities or URLs
  #   amp('One <span class="amp">&amp;</span> two')
  #   # => 'One <span class="amp">&amp;</span> two'
  #   amp('&ldquo;this&rdquo; & <a href="/?that&amp;test">that</a>')
  #   # => '&ldquo;this&rdquo; <span class="amp">&amp;</span> <a href="/?that&amp;test">that</a>'
  #
  # @example It should ignore standalone amps that are in attributes
  #   amp('<link href="xyz.html" title="One & Two">xyz</link>')
  #   # => '<link href="xyz.html" title="One & Two">xyz</link>'
  #
  # @param [String] text input text
  # @return [String] input text with ampersands wrapped
  def amp(text)
    # $1 is the part before the caps and $2 is the amp match
    exclude_sensitive_tags(text) do |t|
      t.gsub(/(\s|&nbsp;)&(?:amp;|#38;)?(\s|&nbsp;)/) { |str|
        $1 + '<span class="amp">&amp;</span>' + $2
      }.gsub(/(\w+)="(.*?)<span class="amp">&amp;<\/span>(.*?)"/, '\1="\2&amp;\3"')
    end
  end

  # replaces space(s) before the last word (or tag before the last word)
  # before an optional closing element (<tt>a</tt>, <tt>em</tt>,
  # <tt>span</tt>, strong) before a closing tag (<tt>p</tt>, <tt>h[1-6]</tt>,
  # <tt>li</tt>, <tt>dt</tt>, <tt>dd</tt>) or the end of the string.
  #
  # @example
  #   widont('A very simple test')
  #   # => 'A very simple&nbsp;test'
  #
  # @example Single word items shouldn't be changed
  #   widont('Test')
  #   # => 'Test'
  #   widont(' Test')
  #   # => ' Test'
  #   widont('<ul><li>Test</p></li><ul>')
  #   # => '<ul><li>Test</p></li><ul>'
  #   widont('<ul><li> Test</p></li><ul>')
  #   # => '<ul><li> Test</p></li><ul>'
  #
  # @example Nested tags
  #   widont('<p>In a couple of paragraphs</p><p>paragraph two</p>')
  #   # => '<p>In a couple of&nbsp;paragraphs</p><p>paragraph&nbsp;two</p>'
  #   widont('<h1><a href="#">In a link inside a heading</i> </a></h1>')
  #   # => '<h1><a href="#">In a link inside a&nbsp;heading</i> </a></h1>'
  #   widont('<h1><a href="#">In a link</a> followed by other text</h1>')
  #   # => '<h1><a href="#">In a link</a> followed by other&nbsp;text</h1>'
  #
  # @example Empty HTMLs shouldn't error
  #   widont('<h1><a href="#"></a></h1>')
  #   # => '<h1><a href="#"></a></h1>'
  #
  # @example Excluded tags
  #   widont('<div>Divs get no love!</div>')
  #   # => '<div>Divs get no love!</div>'
  #   widont('<pre>Neither do PREs</pre>')
  #   # => '<pre>Neither do PREs</pre>'
  #   widont('<div><p>But divs with paragraphs do!</p></div>')
  #   # => '<div><p>But divs with paragraphs&nbsp;do!</p></div>'
  #
  # @see http://mucur.name/posts/widon-t-and-smartypants-helpers-for-rails
  # @see http://shauninman.com/archive/2006/08/22/widont_wordpress_plugin
  # @param [String] text input text
  # @return [String] input text with non-breaking spaces inserted
  def widont(text)
    exclude_sensitive_tags(text) do |t|
      t.gsub(%r{
        (<[^/][^>]*?>)|                                 # Ignore any opening tag, so we don't mess up attribute values
        ((?:</?(?:a|em|span|strong|i|b)[^>]*>)|[^<>\s]) # must be proceeded by an approved inline opening or closing tag or a nontag/nonspace
        \s+                                             # the space to replace
        (([^<>\s]+)                                     # must be flollowed by non-tag non-space characters
        \s*                                             # optional white space!
        (</(a|em|span|strong|i|b)>\s*)*                 # optional closing inline tags with optional white space after each
        ((</(p|h[1-6]|li|dt|dd)>)|$))                   # end with a closing p, h1-6, li or the end of the string
      }xm) { |match| $1 ? match : $2 + (match.include?('&nbsp;') ? ' ' : '&nbsp;') + $3 } # Make sure to not add another nbsp before one already there
    end
  end

  # surrounds two or more consecutive captial letters, perhaps with interspersed digits and periods
  # in a span with a styled class.
  #
  # @example
  #   caps("A message from KU")
  #   # => 'A message from <span class="caps">KU</span>'
  #
  # @example Allows digits
  #   caps("A message from 2KU2 with digits")
  #   # => 'A message from <span class="caps">2KU2</span> with digits'
  #
  # @example Allows ampersands
  #   caps("A phone bill from AT&T")
  #   # => 'A phone bill from <span class="caps">AT&amp;T</span>'
  #
  # @example Ignores HTML attributes
  #   caps('Download <a href="file.doc" title="PDF document">this file</a>')
  #   # => 'Download <a href="file.doc" title="PDF document">this file</a>'
  #
  # @example All caps with with apostrophes in them shouldn't break. Only handles dump apostrophes though.
  #   caps("JIMMY'S")
  #   # => '<span class="caps">JIMMY\\'S</span>'
  #   caps("<i>D.O.T.</i>HE34T<b>RFID</b>")
  #   # => '<i><span class="caps">D.O.T.</span></i><span class="caps">HE34T</span><b><span class="caps">RFID</span></b>'
  #
  # @example Sequences of capitalised letters with spaces are not eligible, since they may be names.
  #   caps("L.A.P.D")
  #   # => '<span class="caps">L.A.P.D.</span>'
  #   caps("L. A. Paul")
  #   # => 'L. A. Paul'
  #
  # @param [String] text input text
  # @return [String] input text with caps wrapped
  def caps(text)
    exclude_sensitive_tags(text) do |t|
      # $1 and $2 are excluded HTML tags, $3 is the part before the caps and $4 is the caps match
      t.gsub(%r{
          (<[^/][^>]*?>)|                                      # Ignore any opening tag, so we don't mess up attribute values
          (\s|&nbsp;|^|'|"|>|)                                 # Make sure our capture is preceded by whitespace or quotes
          ([A-Z\d](?:(\.|'|&|&amp;|&\#38;)?[A-Z\d][\.']?){1,}) # Capture capital words, with optional dots, numbers or ampersands in between
          (?!\w)                                               # ...which must not be followed by a word character.
        }x) do |str|
        tag, before, caps = $1, $2, $3

        # Do nothing with the contents if ignored tags, the inside of an opening HTML element
        # so we don't mess up attribute values, or if our capture is only digits.
        if tag || caps =~ /^\d+\.?$/
          str
        elsif $3 =~ /^[\d\.]+$/
          before + caps
        else
          before + '<span class="caps">' + caps + '</span>'
        end
      end
    end
  end

  # encloses initial single or double quote, or their entities
  # (optionally preceeded by a block element and perhaps an inline element)
  # with a span that can be styled.
  #
  # @example
  #   initial_quotes('"With primes"')
  #   # => '<span class="dquo">"</span>With primes"'
  #   initial_quotes("'With single primes'")
  #   # => '<span class="quo">\\'</span>With single primes\\''
  #
  # @example With primes and links
  #   initial_quotes('<a href="#">"With primes and a link"</a>')
  #   # => '<a href="#"><span class="dquo">"</span>With primes and a link"</a>'
  #
  # @example with Smartypants-quotes
  #   initial_quotes('&#8220;With smartypanted quotes&#8221;')
  #   # => '<span class="dquo">&#8220;</span>With smartypanted quotes&#8221;'
  #
  # @param [String] text input text
  # @return [String] input text with initial quotes wrapped
  def initial_quotes(text)
    # $1 is the initial part of the string, $2 is the quote or entitity, and $3 is the double quote
    exclude_sensitive_tags(text) do |t|
      t.gsub(/((?:<(?:h[1-6]|p|li|dt|dd)[^>]*>|^)\s*(?:<(?:a|em|strong|span)[^>]*>)?)('|&#8216;|&lsquo;|("|&#8220;|&ldquo;))/) {$1 + "<span class=\"#{'d' if $3}quo\">#{$2}</span>"}
    end
  end

  # Converts special characters (excluding HTML tags) to HTML entities.
  #
  # @example
  #   entities("Aloë Vera") # => "Alo&euml; Vera"
  #
  # @param [String] text input text
  # @return [String] input text with all special characters converted to
  #   HTML entities.
  def entities(text)
    o = ''
    text.scan(/(?x)

        ( <\?(?:[^?]*|\?(?!>))*\?>
        | <!-- (?m:.*?) -->
        | <\/? (?i:a|abbr|acronym|address|applet|area|b|base|basefont|bdo|big|blockquote|body|br|button|caption|center|cite|code|col|colgroup|dd|del|dfn|dir|div|dl|dt|em|fieldset|font|form|frame|frameset|h1|h2|h3|h4|h5|h6|head|hr|html|i|iframe|img|input|ins|isindex|kbd|label|legend|li|link|map|menu|meta|noframes|noscript|object|ol|optgroup|option|p|param|pre|q|s|samp|script|select|small|span|strike|strong|style|sub|sup|table|tbody|td|textarea|tfoot|th|thead|title|tr|tt|u|ul|var)\b
            (?:[^>"']|"[^"]*"|'[^']*')*
          >
        | &(?:[a-zA-Z0-9]+|\#[0-9]+|\#x[0-9a-fA-F]+);
        )
        |([^<&]+|[<&])

      /x) do |tag, text|
      o << tag.to_s
      o << encode(text.to_s)
    end
    o
  end

  # main function to do all the functions from the method.
  #
  # @param [String] text input text
  # @return [String] input text with all filters applied
  def improve(text)
    initial_quotes(caps(smartypants(widont(amp(text)))))
  end

private

  # Convert characters from the map in ./lib/characters.txt
  # Code taken from TextMate HTML bundle
  #
  # @param [String] text input text
  # @return [String] input text with all special characters converted to
  #   HTML entities.
  def encode(text)
    @char_to_entity ||= begin
      map = {}
      File.read(File.join(File.dirname(__FILE__), 'characters.txt')).scan(/^(\d+)\s*(.+)$/) do |key, value|
        map[[key.to_i].pack('U')] = value
      end
      map
    end

    text.gsub(/[^\x00-\x7F]|["'<>&]/) do |ch|
      ent = @char_to_entity[ch]
      ent ? "&#{ent};" : sprintf("&#x%02X;", ch.unpack("U")[0])
    end
  end

  # Hackish text filter that will make sure our text filters leave
  # sensitive tags alone without resorting to a full-blown HTML parser.
  #
  # Sensitive tags are tags with literal contents, which we do not
  # want to change. It currently ignores: <pre>, <code>, <kbd>, <math>
  # and <script>.
  #
  # The idea is simple: every text filter is applied as a block to this
  # method. This will preprocess the text and replace any sensitive tags
  # with a MD5 hash of its entire contents. Then the filter is called,
  # and then the hashes are replaced back with their original content.
  #
  # @yield [hashed_text] Hands you the input text with all sensitive tags
  #   hashed. The block's result will be unhashed and then returned.
  # @param [String] text
  # @return [String] input with sensitive tags restored
  def exclude_sensitive_tags(text)
    @exluded_sensitive_tags = {}
    modified_text = text.gsub(/<(#{EXCLUDED_TAGS .join('|')})[^>]*>.*?<\/\1>/mi) do |script|
      hash = Digest::MD5.hexdigest(script)
      @exluded_sensitive_tags[hash] = script
      hash
    end
    yield(modified_text).gsub(/#{@exluded_sensitive_tags.keys.join('|')}/) do |h|
      @exluded_sensitive_tags[h]
    end
  end

  # Array of all the senstive tags that should be ignored by all the text filters.
  EXCLUDED_TAGS  = %w{head pre code kbd math script textarea title}

  extend self
end
