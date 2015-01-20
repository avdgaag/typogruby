# -*- encoding: utf-8 -*-
require 'minitest/autorun'
require File.expand_path('../../lib/typogruby', __FILE__)

class TypogrubyTest < Minitest::Test
  include Typogruby

  def test_should_replace_amps
    assert_equal 'One <span class="amp">&amp;</span> two', amp('One & two')
    assert_equal 'One <span class="amp">&amp;</span> two', amp('One &amp; two')
    assert_equal 'One <span class="amp">&amp;</span> two', amp('One &#38; two')
    assert_equal 'One&nbsp;<span class="amp">&amp;</span>&nbsp;two', amp('One&nbsp;&amp;&nbsp;two')
  end

  def test_should_ignore_special_amps
    assert_equal 'One <span class="amp">&amp;</span> two', amp('One <span class="amp">&amp;</span> two')
    assert_equal '&ldquo;this&rdquo; <span class="amp">&amp;</span> <a href="/?that&amp;test">that</a>', amp('&ldquo;this&rdquo; & <a href="/?that&amp;test">that</a>')
    assert_equal %Q{<script>\nvar x = "FOO & BAR";\n</script>"}, initial_quotes(%Q{<script>\nvar x = "FOO & BAR";\n</script>"})
  end

  def test_should_ignore_standalone_amps_in_attributes
    assert_equal '<link href="xyz.html" title="One &amp; Two">xyz</link>', amp('<link href="xyz.html" title="One & Two">xyz</link>')
  end

  def test_should_replace_caps
    assert_equal 'A message from <span class="caps">KU</span>', caps("A message from KU")
    assert_equal 'Replace text <a href="."><span class="caps">IN</span></a> tags', caps('Replace text <a href=".">IN</a> tags')
    assert_equal 'Replace text <i><span class="caps">IN</span></i> tags', caps('Replace text <i>IN</i> tags')
  end

  def test_should_ignore_special_case_caps
    assert_equal 'It should ignore just numbers like 1234.', caps('It should ignore just numbers like 1234.')
    assert_equal '<pre>CAPS</pre> more <span class="caps">CAPS</span>', caps("<pre>CAPS</pre> more CAPS")
    assert_equal '<Pre>CAPS</PRE> with odd tag names <span class="caps">CAPS</span>', caps("<Pre>CAPS</PRE> with odd tag names CAPS")
    assert_equal 'A message from <span class="caps">2KU2</span> with digits', caps("A message from 2KU2 with digits")
    assert_equal 'Dotted caps followed by spaces should never include them in the wrap <span class="caps">D.O.T.</span>   like so.', caps("Dotted caps followed by spaces should never include them in the wrap D.O.T.   like so.")
    assert_equal 'Caps in attributes (<span title="Example CAPS">example</span>) should be ignored', caps('Caps in attributes (<span title="Example CAPS">example</span>) should be ignored')
    assert_equal '<head><title>CAPS Example</title></head>', caps('<head><title>CAPS Example</title></head>')
  end

  def test_should_not_break_caps_with_apostrophes
    assert_equal '<span class="caps">JIMMY\'S</span>', caps("JIMMY'S")
    assert_equal '<i><span class="caps">D.O.T.</span></i><span class="caps">HE34T</span><b><span class="caps">RFID</span></b>', caps("<i>D.O.T.</i>HE34T<b>RFID</b>")
  end

  def test_should_not_break_caps_with_ampersands
    assert_equal '<span class="caps">AT&T</span>', caps("AT&T")
    assert_equal '<span class="caps">AT&amp;T</span>', caps("AT&amp;T")
    assert_equal '<span class="caps">AT&#38;T</span>', caps("AT&#38;T")
  end

  def test_should_replace_quotes
    assert_equal '<span class="dquo">"</span>With primes"', initial_quotes('"With primes"')
    assert_equal '<span class="quo">\'</span>With single primes\'', initial_quotes("'With single primes'")
    assert_equal '<a href="#"><span class="dquo">"</span>With primes and a link"</a>', initial_quotes('<a href="#">"With primes and a link"</a>')
    assert_equal '<span class="dquo">&#8220;</span>With smartypanted quotes&#8221;', initial_quotes('&#8220;With smartypanted quotes&#8221;')
    assert_equal '<span class="quo">&lsquo;</span>With manual quotes&rsquo;', initial_quotes('&lsquo;With manual quotes&rsquo;')
    assert_equal %Q{<script>\nvar x = "FOO BAR and BAZ";\n</script>"}, initial_quotes(%Q{<script>\nvar x = "FOO BAR and BAZ";\n</script>"})
  end

  def test_should_not_replace_quotes_in_scripts
    assert_equal %Q{<script>\nvar x = "foo" +\n"bar";\n</script>"}, initial_quotes(%Q{<script>\nvar x = "foo" +\n"bar";\n</script>"})
  end

  def test_should_apply_smartypants
    assert_equal 'The &#8220;Green&#8221; man', smartypants('The "Green" man')
  end

  def test_should_apply_all_filters
    assert_equal '<h2><span class="dquo">&#8220;</span>Jayhawks&#8221; <span class="amp">&amp;</span> <span class="caps">KU</span> fans act extremely&nbsp;obnoxiously</h2>', improve('<h2>"Jayhawks" & KU fans act extremely obnoxiously</h2>')
  end

  def test_should_prevent_widows
    assert_equal 'A very simple&nbsp;test', widont('A very simple test')
  end

  def test_should_not_change_single_word_items
    assert_equal 'Test', widont('Test')
    assert_equal ' Test', widont(' Test')
    assert_equal '<ul><li>Test</p></li><ul>', widont('<ul><li>Test</p></li><ul>')
    assert_equal '<ul><li> Test</p></li><ul>', widont('<ul><li> Test</p></li><ul>')
    assert_equal '<p>In a couple of&nbsp;paragraphs</p><p>paragraph&nbsp;two</p>', widont('<p>In a couple of paragraphs</p><p>paragraph two</p>')
    assert_equal '<h1><a href="#">In a link inside a&nbsp;heading</i> </a></h1>', widont('<h1><a href="#">In a link inside a heading</i> </a></h1>')
    assert_equal '<h1><a href="#">In a link</a> followed by other&nbsp;text</h1>', widont('<h1><a href="#">In a link</a> followed by other text</h1>')
  end

  def test_should_not_add_nbsp_before_another
    assert_equal 'Sentence with one&nbsp;nbsp', widont('Sentence with one&nbsp;nbsp')
  end

  def test_should_not_error_on_empty_html
    assert_equal '<h1><a href="#"></a></h1>', widont('<h1><a href="#"></a></h1>')
  end

  def test_should_ignore_caps_in_special_tags
    assert_equal '<title>I like JSON</title>', caps('<title>I like JSON</title>')
  end

  def test_should_ignore_widows_in_special_tags
    assert_equal '<div>Divs get no love!</div>', widont('<div>Divs get no love!</div>')
    assert_equal '<pre>Neither do PREs</pre>', widont('<pre>Neither do PREs</pre>')
    assert_equal '<title>or titles</title>', widont('<title>or titles</title>')
    assert_equal '<textarea>nor text in textarea</textarea>', widont('<textarea>nor text in textarea</textarea>')
    assert_equal "<script>\nreturn window;\n</script>", widont("<script>\nreturn window;\n</script>")
    assert_equal '<div><p>But divs with paragraphs&nbsp;do!</p></div>', widont('<div><p>But divs with paragraphs do!</p></div>')
  end

  def test_should_ignore_attributes_across_mutliple_lines_when_preventing_widows
    assert_equal %Q{<div id="aniver" style="\nbackground-image:url('/static/colorfulbackground.png');\nbackground-repeat:no-repeat;\ntext-align:center;\nmargin:0;\npadding:0;\nbackground-size: 100% 100%;">},
      widont(%Q{<div id="aniver" style="\nbackground-image:url('/static/colorfulbackground.png');\nbackground-repeat:no-repeat;\ntext-align:center;\nmargin:0;\npadding:0;\nbackground-size: 100% 100%;">})
  end

  def test_should_convert_entities
    assert_equal "Vari&euml;ren&hellip;", entities('Variëren…')
    assert_equal "<p>Ol&eacute;</p>", entities('<p>Olé</p>')
  end

  def test_should_leave_sensitive_tags_alone
    %w{script pre code kbd math}.each do |tag_name|
      test_string = "<#{tag_name}>“CAPS & chårs” and widows</#{tag_name}>"
      assert_equal test_string, improve(test_string)
    end
  end

  def test_should_not_forget_about_duplicate_sensitive_tags
    %w{script pre code kbd math}.each do |tag_name|
      test_string = "<#{tag_name}>this</#{tag_name}>==<#{tag_name}>this</#{tag_name}>"
      assert_equal test_string, improve(test_string)
    end
  end
end
