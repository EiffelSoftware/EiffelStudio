class
	TEST_WIKI_TEXT

inherit
	EQA_TEST_SET

	TEST_WIKI_TEXT_I
		undefine
			default_create
		end

feature -- Tests

	test_1
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
		do
			create t.make_from_string ("[
[[Property:title|Breakpoint editing]]
[[Property:weight|1]]
[[Property:uuid|1ac830ab-7600-8e52-2351-c515bcc31d41]]
In all flat views ( [[Feature formatters: Flat view|feature flat view]]  and [[Class formatters: Flat view|class flat view]] ), a margin is displayed on the left of the editor. [[Breakpoints|Breakpoints]]  are symbolized there as circles, with different looks depending on their state: enabled (  [[Image:bp-enabled-icon]]  ), disabled (  [[Image:bp-disabled-icon]]  ) or not set (  [[Image:bp-slot-icon]]  ). A small question mark in the circle (  [[Image:bp-enabled-conditional-icon]] ,  [[Image:bp-disabled-conditional-icon]]  ) indicates [[Breakpoint menu|conditional breakpoints]] .

Right-clicking on any breakpoint pops up a context menu:

[[Image:breakpoint-context-menu]]

The first line provides the breakpoint slot index of the selected breakpoint (i.e: the one used in call stack or exception trace output). <br/>
Clicking one of the three first entries of the context menu changes the state of the breakpoint that was right-clicked. The last entry ('''Run to This Point''') launches the debugged application so that it will stop as soon as the selected breakpoint is encountered, as if the breakpoint had been enabled. <br/>


"Edit This Breakpoint" allows you to edit the parameters of the breakpoint (condition, hit count, when hits actions...) through the breakpoint dialog. On the first tab, '''Context''', the breakpoint dialog provides access to the associated tags, condition, and hit count control. And on the second tab, it allows you to associate '''When hits...''' action(s) with the breakpoint.

{| 
|- 
| 
'''Context''' tab
 [[Image:breakpoint-dialog-context|Context tab]]  
| 
'''When hits ...''' action tab
 [[Image:breakpoint-dialog-when-hits-action|When hits... tab]]  
|}


Tags allow you to identify a collection of breakpoints, either from the [[Breakpoint information command|breakpoints tool]] , or in the parameters of "When hits .." actions. <br/>
Any existing breakpoint can be referenced by an implicit tag with the form: ''"'''bp:'''cluster.{CLASS}.feature@index"'' (cluster is not mandatory).<br/>

{{sample|A sample breakpoint tag: "'''bp:'''elks.{LINKED_LIST}.extend@2"}}

* the "Condition" allows you to set a condition for stopping. 
* the "Hit count" allows you to set a condition on hitcount for stopping. 
* And the "When Hits..." allows you to associate specific actions with the breakpoint: 
** Print message: display the expanded message to the output (there are predefined variables, and you can also evaluate expressions).
** Disable/Restore Assertion Checking: this might be useful to deactivate assertion checking on a specific part of the execution.
** Record Execution: start or stop the execution recording (cf: [[Execution record and replay|Execution recording and replay]] )
** Enable/Disable Breakpoints: either use tags or implicit tags (ex: ''"bp:elks.{LINKED_LIST}.extend@2"''), to reference a set of existing breakpoints. This can be pretty useful to enable a breakpoint only if the execution takes a specific execution path.
** Reset Hits count




"Edit Condition" allows you to set a condition for stopping, it opens the same dialog as "Edit This Breakpoint", but focus on the "condition" field.

[[Image:breakpoint-dialog-condition]]

"Hit count" allows you to set a condition on hitcount for stopping

[[Image:breakpoint-dialog-hit-count]]

"When hits ..." allows you to do an action when execution stops on this breakpoint. This can be `print message' for example.

[[Image:breakpoint-dialog-when-hits]]

{{seealso| [[Breakpoint commands|Breakpoint commands]], [[Breakpoint information command|Breakpoint information command]] }}
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", not o.is_empty)
		end

	test_toc_disabled
		local
			p: WIKI_PAGE
			t: WIKI_CONTENT_TEXT
			o: STRING
			l_expected_output: STRING
		do
			create t.make_from_string ("{
begin
__NOTOC__
=One=
== one.1 ==
== one.2 ==
== one.3 ==
=Two=
== two.1 ==
== two.2 ==
=Three=
== three.1 ==
== three.2 ==
== three.3 ==
=And the last one=
== with spaces in text==
== summer:été==
end
}")
			l_expected_output := "{
<div class="wikipage"><p>begin

</p>

<a id="One"></a><h1>One</h1>

<a id="one.1"></a><h2>one.1</h2>

<a id="one.2"></a><h2>one.2</h2>

<a id="one.3"></a><h2>one.3</h2>

<a id="Two"></a><h1>Two</h1>

<a id="two.1"></a><h2>two.1</h2>

<a id="two.2"></a><h2>two.2</h2>

<a id="Three"></a><h1>Three</h1>

<a id="three.1"></a><h2>three.1</h2>

<a id="three.2"></a><h2>three.2</h2>

<a id="three.3"></a><h2>three.3</h2>

<a id="And_the_last_one"></a><h1>And the last one</h1>

<a id="with_spaces_in_text"></a><h2>with spaces in text</h2>

<a id="summer:%C3%A9t%C3%A9"></a><h2>summer:été</h2>
<p>end
</p>
</div>

}"

			create p.make_with_title ("Test TOC")
			p.set_text (t)

			create o.make_empty

			p.process (new_xhtml_generator (o))
			assert ("o", same_output (o, l_expected_output))
		end

	test_toc
		local
			p: WIKI_PAGE
			t: WIKI_CONTENT_TEXT
			o: STRING
			l_expected_output: STRING
		do
			create t.make_from_string ("{
begin
__TOC__
=One=
== one.1 ==
== one.2 ==
== one.3 ==
=Two=
== two.1 ==
== two.2 ==
=Three=
== three.1 ==
== three.2 ==
== three.3 ==
end
}")
			l_expected_output := "{
<div class="wikipage"><p>begin

<div class="wiki-toc">
<ol><a id="toc"></a><span class="title">Contents</span>
<li><a href="#One">One</a><ol>
	<li><a href="#one.1">one.1</a></li>
	<li><a href="#one.2">one.2</a></li>
	<li><a href="#one.3">one.3</a></li>
	</ol>
</li>
<li><a href="#Two">Two</a><ol>
	<li><a href="#two.1">two.1</a></li>
	<li><a href="#two.2">two.2</a></li>
	</ol>
</li>
<li><a href="#Three">Three</a><ol>
	<li><a href="#three.1">three.1</a></li>
	<li><a href="#three.2">three.2</a></li>
	<li><a href="#three.3">three.3</a></li>
	</ol>
</li>
</ol>
</div>

</p>

<a id="One"></a><h1>One</h1>

<a id="one.1"></a><h2>one.1</h2>

<a id="one.2"></a><h2>one.2</h2>

<a id="one.3"></a><h2>one.3</h2>

<a id="Two"></a><h1>Two</h1>

<a id="two.1"></a><h2>two.1</h2>

<a id="two.2"></a><h2>two.2</h2>

<a id="Three"></a><h1>Three</h1>

<a id="three.1"></a><h2>three.1</h2>

<a id="three.2"></a><h2>three.2</h2>

<a id="three.3"></a><h2>three.3</h2>
<p>end
</p>
</div>

}"

			create p.make_with_title ("Test TOC")
			p.set_text (t)

			create o.make_empty

			p.process (new_xhtml_generator (o))
			assert ("o", same_output (o, l_expected_output))
		end

	test_toc_limited_depth
		local
			p: WIKI_PAGE
			t: WIKI_CONTENT_TEXT
			o: STRING
			l_expected_output: STRING
		do
			create t.make_from_string ("{
begin
{{TOC|limit=2}}
=One=
== one.1 ==
=== one.1.1 ===
=== one.1.2 ===
== one.2 ==
== one.3 ==
=Two=
== two.1 ==
== two.2 ==
=Three=
== three.1 ==
== three.2 ==
=== three.2.1 ===
=== three.2.2 ===
== three.3 ==
end
}")
			l_expected_output := "{
<div class="wikipage"><p>begin

<div class="wiki-toc">
<ol><a id="toc"></a><span class="title">Contents</span>
<li><a href="#One">One</a><ol>
	<li><a href="#one.1">one.1</a></li>
	<li><a href="#one.2">one.2</a></li>
	<li><a href="#one.3">one.3</a></li>
	</ol>
</li>
<li><a href="#Two">Two</a><ol>
	<li><a href="#two.1">two.1</a></li>
	<li><a href="#two.2">two.2</a></li>
	</ol>
</li>
<li><a href="#Three">Three</a><ol>
	<li><a href="#three.1">three.1</a></li>
	<li><a href="#three.2">three.2</a></li>
	<li><a href="#three.3">three.3</a></li>
	</ol>
</li>
</ol>
</div>

</p>

<a id="One"></a><h1>One</h1>

<a id="one.1"></a><h2>one.1</h2>

<a id="one.1.1"></a><h3>one.1.1</h3>

<a id="one.1.2"></a><h3>one.1.2</h3>

<a id="one.2"></a><h2>one.2</h2>

<a id="one.3"></a><h2>one.3</h2>

<a id="Two"></a><h1>Two</h1>

<a id="two.1"></a><h2>two.1</h2>

<a id="two.2"></a><h2>two.2</h2>

<a id="Three"></a><h1>Three</h1>

<a id="three.1"></a><h2>three.1</h2>

<a id="three.2"></a><h2>three.2</h2>

<a id="three.2.1"></a><h3>three.2.1</h3>

<a id="three.2.2"></a><h3>three.2.2</h3>

<a id="three.3"></a><h2>three.3</h2>
<p>end
</p>
</div>

}"

			create p.make_with_title ("Test TOC")
			p.set_text (t)

			create o.make_empty

			p.process (new_xhtml_generator (o))
			assert ("o", same_output (o, l_expected_output))
		end

	test_anchor_name
		local
			o: STRING
			vis: like new_xhtml_generator
		do
			create o.make_empty
			vis := new_xhtml_generator (o)
			assert ("valid anchor name", same_output (vis.anchor_name ("A text with spaces", True), "A_text_with_spaces"))
			assert ("valid anchor name", same_output (vis.anchor_name ("unexpected # char", True), "unexpected_%%23_char"))
			assert ("valid anchor name", same_output (vis.anchor_name ("summer=été", True), "summer=%%C3%%A9t%%C3%%A9"))
		end

	test_html
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
		do
			create t.make_from_string ("=test=%N<div>toto</div>%Nend")
			e := "[

<a id="test"></a><h1>test</h1>
<p><div>toto</div>
end
</p>

]"

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", same_output (o, e))
		end

	test_paragraph
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			l_expected_output: STRING
		do
			create t.make_from_string ("[
This is a first line.
Then the second line.

Next paragraph, line 1.
line 2.
end.
]")
			l_expected_output := "[
<p>This is a first line.
Then the second line.
</p>
<p>Next paragraph, line 1.
line 2.
end.
</p>

]"

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", same_output (o, l_expected_output))
		end

	test_paragraph_with_cr
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			l_expected_output: STRING
		do
			create t.make_from_string ("This is a first line.%R%NThen the second line.%R%N%R%NNext paragraph, line 1.%R%Nline 2.%R%Nend.%R%N")
			l_expected_output := "<p>This is a first line.%R%NThen the second line.%R%N</p>%N<p>Next paragraph, line 1.%R%Nline 2.%R%Nend.%R%N</p>%N"

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", same_output (o, l_expected_output))
		end

	test_paragraph_in_section
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			l_expected_output: STRING
		do
			create t.make_from_string ("[
== Test ==
This is a first line.
Then the second line.

Next paragraph, line 1.
line 2.
end.
]")
			l_expected_output := "[
			
<a id="Test"></a><h2>Test</h2>
<p>This is a first line.
Then the second line.
</p>
<p>Next paragraph, line 1.
line 2.
end.
</p>

]"

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", same_output (o, l_expected_output))
		end

	test_template
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			l_expected_output: STRING
		do
			create t.make_from_string ("[
==test==
{{seealso| [[Breakpoint commands|Breakpoint commands]], [[Breakpoint information command|Breakpoint information command]] }}

==end==
			]")

			l_expected_output := "[

<a id="test"></a><h2>test</h2>
<p>Template#seealso
1= <a href="Breakpoint commands" class="wiki_link wiki_notfound">Breakpoint commands</a>, <a href="Breakpoint information command" class="wiki_link wiki_notfound">Breakpoint information command</a>  
2={{{2}}} 
3={{{3}}}

</p>

<a id="end"></a><h2>end</h2>

]"

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", same_output (o, l_expected_output))
		end

	test_template_2
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			l_expected_output: STRING
		do
			create t.make_from_string ("[
==test==
{{seealso| [[Breakpoint commands|Breakpoint commands]] | [[Breakpoint information command|Breakpoint information command]] }}

==end==
			]")

			l_expected_output := "[

<a id="test"></a><h2>test</h2>
<p>Template#seealso
1= <a href="Breakpoint commands" class="wiki_link wiki_notfound">Breakpoint commands</a>  
2= <a href="Breakpoint information command" class="wiki_link wiki_notfound">Breakpoint information command</a>  
3={{{3}}}

</p>

<a id="end"></a><h2>end</h2>

]"

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", same_output (o, l_expected_output))
		end

	test_template_3_with_name
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			l_expected_output: STRING
		do
			create t.make_from_string ("[
==test==
{{Rule|name=foo|text=bar}}
==end==
			]")

			l_expected_output := "[

<a id="test"></a><h2>test</h2>
<p>Template#Rule
name=foo
text=bar

</p>

<a id="end"></a><h2>end</h2>

]"

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", same_output (o, l_expected_output))
		end

	test_template_with_unknown_name
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			l_expected_output: STRING
		do
			create t.make_from_string ("[
==test==
{{unknown| [[Breakpoint commands|Breakpoint commands]], [[Breakpoint information command|Breakpoint information command]] }}

==end==
			]")

			l_expected_output := "[

<a id="test"></a><h2>test</h2>
<p><div class="wiki-template unknown" class="inline"><strong>unknown</strong>:  <a href="Breakpoint commands" class="wiki_link wiki_notfound">Breakpoint commands</a>, <a href="Breakpoint information command" class="wiki_link wiki_notfound">Breakpoint information command</a> </div>
</p>

<a id="end"></a><h2>end</h2>

]"

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", same_output (o, l_expected_output))
		end

	test_template_with_trailing_space
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			l_expected_output: STRING
		do
			create t.make_from_string ("[
==test==
{{SeeAlso | [[Breakpoint commands|Breakpoint commands]], [[Breakpoint information command|Breakpoint information command]] }}

==end==
			]")

			l_expected_output := "[

<a id="test"></a><h2>test</h2>
<p>Template#SeeAlso
1= <a href="Breakpoint commands" class="wiki_link wiki_notfound">Breakpoint commands</a>, <a href="Breakpoint information command" class="wiki_link wiki_notfound">Breakpoint information command</a>  
2={{{2}}} 
3={{{3}}}

</p>

<a id="end"></a><h2>end</h2>

]"

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", same_output (o, l_expected_output))
		end

	test_table
		local
			t: WIKI_CONTENT_TEXT
			e,o: STRING
		do
			create t.make_from_string ("[
{| class="my-table"
|+ class="my-caption"|a table
|-
!style="text-align:left;"|Name
!Quantity
!Note
|-
|First
|10
|a comment
|-
|Second
|4
|another comment
|-
|Third
|1
|a last comment
|- class="total"
!Total
|15
|
|}
			]")

			e := "{
<p><table class="my-table"><caption class="my-caption">a table</caption>
<tr><th style="text-align:left;">Name</th><th>Quantity</th><th>Note</th></tr>
<tr><td>First</td><td>10</td><td>a comment</td></tr>
<tr><td>Second</td><td>4</td><td>another comment</td></tr>
<tr><td>Third</td><td>1</td><td>a last comment</td></tr>
<tr class="total"><th>Total</th><td>15</td><td></td></tr>
</table>
</p>

}"
			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", not o.is_empty)
			assert ("expected", o.same_string (e))
		end

	test_table_inlined
		local
			t: WIKI_CONTENT_TEXT
			e,o: STRING
		do
			create t.make_from_string ("[
{|
!Name!!Quantity!!Note
|-
|First||10||a comment
|-
|Second||4||another comment
|-
|Third||1||a last comment
|-
!Total||15!!...
|}
			]")

			e := "{
<p><table><tr><th>Name</th><th>Quantity</th><th>Note</th></tr>
<tr><td>First</td><td>10</td><td>a comment</td></tr>
<tr><td>Second</td><td>4</td><td>another comment</td></tr>
<tr><td>Third</td><td>1</td><td>a last comment</td></tr>
<tr><th>Total</th><td>15</td><th>...</th></tr>
</table>
</p>

}"
			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", not o.is_empty)
			assert ("expected", o.same_string (e))
		end

	test_table_with_wiki_content
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
		do
			create t.make_from_string ("[
{| 
|- 
| '''Context''' tab
 [[Image:breakpoint-dialog-context|Context tab]]  
| 
'''When hits ...''' action tab
 [[Image:breakpoint-dialog-when-hits-action|When hits... tab]]  
|}
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", not o.is_empty)
		end

	test_table_with_wiki_code_and_bang
		local
			t: WIKI_CONTENT_TEXT
			o,e: STRING
		do
			create t.make_from_string ("[
{| 
|- 
| Test 
| 
<code>
bang-bang !! double exclamation marks
</code>..
|}
			]")
			e := "[
<p><table><tr><td> Test </td><td> 
<code>bang-bang !! double exclamation marks</code><br/>
..</td></tr>
</table>
</p>

			]"--

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", not o.is_empty)
			assert ("expected", o.same_string (e))

			create t.make_from_string ("[
{| 
|- 
| Test 
| 
<code>
bang-bang <em>!!</em> double exclamation marks
</code>..
|}
			]")
			e := "[
<p><table><tr><td> Test </td><td> 
<code>bang-bang &lt;em&gt;!!&lt;/em&gt; double exclamation marks</code><br/>
..</td></tr>
</table>
</p>

			]"--

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", not o.is_empty)
			assert ("expected", o.same_string (e))

			create t.make_from_string ("[
{|
|-
| Test
|
```
bang-bang !! double exclamation marks
```..
|}
			]")
			e := "[
<p><table><tr><td> Test</td><td>
<code>bang-bang !! double exclamation marks</code><br/>
..</td></tr>
</table>
</p>

			]"--

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", not o.is_empty)
			assert ("expected", o.same_string (e))

			create t.make_from_string ("[
{|
|-
| Test
|
`bang-bang !! double exclamation marks`..
|}
			]")
			e := "[
<p><table><tr><td> Test</td><td>
<code class="inline">bang-bang !! double exclamation marks</code>..</td></tr>
</table>
</p>

			]"--

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", not o.is_empty)
			assert ("expected", o.same_string (e))
		end

	test_preformatted_text
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
		do
			create t.make_from_string ("{
begin
    abc
    def
    ghi 
end
}")

e := "{
<p>begin
</p>
<pre>   abc
   def
   ghi </pre><p>end
</p>

}"

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_code
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
		do
			create t.make_from_string ("[
<code lang="eiffel">
class FOO [BAR]
feature
end
</code>
			]")

e := "{
<p><code lang="eiffel">class FOO [BAR]
feature
end</code><br/>

</p>

}"

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end


	test_code_2
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
		do
			create t.make_from_string ("[
The creation procedure
<code>
    make (s, e: G)
</code>
takes ...
			]")

e := "{
<p>The creation procedure
<code>    make (s, e: G)</code><br/>

takes ...
</p>

}"

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_html_code
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
		do
			create t.make_from_string ("[
<code>
<foo>bar</foo>
</code>
			]")

			e := "{
<p><code>&lt;foo&gt;bar&lt;/foo&gt;</code><br/>

</p>

}"

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_code_with_brackets
		local
			t: WIKI_CONTENT_TEXT
			o,e: STRING
		do
			create t.make_from_string ("[
<code lang="eiffel">
class FOO
feature
    do_call (a_procedure: separate PROCEDURE [ANY, TUPLE[separate STRING]]; a_string: separate STRING)
		do
		end
end
</code>
			]")
			e := "{
<p><code lang="eiffel">class FOO
feature
    do_call (a_procedure: separate PROCEDURE [ANY, TUPLE[separate STRING]]; a_string: separate STRING)
		do
		end
end</code><br/>

</p>

}"

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", not o.is_empty)
		end

	test_nowiki
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
		do
			create t.make_from_string ("[
begin/
<nowiki>this is a ''test'' with link as [[Foobar|FooBar link]]</nowiki>
/end
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", o.same_string ("<p>begin/%Nthis is a ''test'' with link as [[Foobar|FooBar link]]%N/end%N</p>%N"))

			create t.make_from_string ("[
begin/
<nowiki>
this is a ''test'' with multiple lines and links as [[Foobar|FooBar link]]
this is a ''test'' with multiple lines and links as [[Foobar|FooBar link]]
this is a ''test'' with multiple lines and links as [[Foobar|FooBar link]]
</nowiki>
/end
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", o.same_string ("<p>begin/%N%Nthis is a ''test'' with multiple lines and links as [[Foobar|FooBar link]]%Nthis is a ''test'' with multiple lines and links as [[Foobar|FooBar link]]%Nthis is a ''test'' with multiple lines and links as [[Foobar|FooBar link]]%N%N/end%N</p>%N"))

			create t.make_from_string ("[
begin/
<nowiki>this is an inline <code>foo.bar + test</code></nowiki>
/end
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", o.same_string ("<p>begin/%Nthis is an inline &lt;code&gt;foo.bar + test&lt;/code&gt;%N/end%N</p>%N"))

			create t.make_from_string ("[
begin/
<nowiki>this is a block
<code>
	class FOO
	feature
	end
</code>
</nowiki>
/end
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", o.same_string ("<p>begin/%Nthis is a block%N&lt;code&gt;%N	class FOO%N	feature%N	end%N&lt;/code&gt;%N%N/end%N</p>%N"))

			create t.make_from_string ("[
begin/
<nowiki>this is a block
```
	class FOO
	feature
	end
```
</nowiki>
/end
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", o.same_string ("<p>begin/%Nthis is a block%N```%N	class FOO%N	feature%N	end%N```%N%N/end%N</p>%N"))

		end

	test_code_3backtiks
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
		do
			create t.make_from_string ("[
begin
```text
class FOO
feature
end
```
end
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", o.same_string ("<p>begin%N<code lang=%"text%">class FOO%Nfeature%Nend</code><br/>%N%Nend%N</p>%N"))



			create t.make_from_string ("[
begin
```eiffel
class FOO
feature
end
```
end
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", o.same_string ("<p>begin%N<code lang=%"eiffel%">class FOO%Nfeature%Nend</code><br/>%N%Nend%N</p>%N"))

			create t.make_from_string ("[
begin
```eiffel
class FOO <foo></bar>
feature
end
```
end
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", o.same_string ("<p>begin%N<code lang=%"eiffel%">class FOO &lt;foo&gt;&lt;/bar&gt;%Nfeature%Nend</code><br/>%N%Nend%N</p>%N"))

			create t.make_from_string ("[
begin
```xml
<code lang="eiffel">
	class FOOBAR
</code>
```
end
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", o.same_string ("<p>begin%N<code lang=%"xml%">&lt;code lang=%"eiffel%"&gt;%N%Tclass FOOBAR%N&lt;/code&gt;</code><br/>%N%Nend%N</p>%N"))

		end

	test_code_single_backtik
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
		do
			create t.make_from_string ("[
begin `FOO.bar` end
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", o.same_string ("<p>begin <code class=%"inline%">FOO.bar</code> end%N</p>%N"))

			create t.make_from_string ("[
begin `FOO.bar and not ending backtick end
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", o.same_string ("<p>begin `FOO.bar and not ending backtick end%N</p>%N"))

			create t.make_from_string ("[
begin `foo <bar> qwe` end
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", o.same_string ("<p>begin <code class=%"inline%">foo &lt;bar&gt; qwe</code> end%N</p>%N"))

			create t.make_from_string ("[
begin `foo <bar>`
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", o.same_string ("<p>begin <code class=%"inline%">foo &lt;bar&gt;</code>%N</p>%N"))
		end

	test_code_single_backtik_with_lt_char
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
		do
			create t.make_from_string ("[
begin
`foobar` operations `<` or `>` or `<=>` `blabla` .

`foo bar`
end
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", o.same_string ("{
<p>begin
<code class="inline">foobar</code> operations <code class="inline">&lt;</code> or <code class="inline">&gt;</code> or <code class="inline">&lt;=&gt;</code> <code class="inline">blabla</code> .
</p>
<p><code class="inline">foo bar</code>
end
</p>

}"
						)
					)
		end

	test_code_single_backtik_escape
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
		do
			create t.make_from_string ("[
begin
Test \`abc' a\`n\`d.
end
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", o.same_string ("{
<p>begin
Test `abc' a`n`d.
end
</p>

}")
				)

			create t.make_from_string ("[
begin
Test \`abc' and `\` and a\b\c.
end
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", o.same_string ("{
<p>begin
Test `abc' and <code class="inline">\</code> and a\b\c.
end
</p>

}")
				)
		end

	test_code_double_backtik
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
		do
			create t.make_from_string ("[
begin `` `FOO.bar' `` end
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", o.same_string ("<p>begin <code class=%"inline%"> `FOO.bar' </code> end%N</p>%N"))
		end


	test_custom_code
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
			gen: like new_xhtml_generator
		do
			create t.make_from_string ("[
<mycode lang="eiffel">
class FOO [BAR]
feature
end
</mycode>
			]")

e := "{
<p><mycode lang="eiffel">class FOO [BAR]
feature
end</mycode><br/>

</p>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			gen.code_aliases.force ("mycode")

			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_list
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
			gen: like new_xhtml_generator
		do
			create t.make_from_string ("[
'''List'''
* this 
* is
* a
* list
* with
** sub item
** sub item
* end
			]")

e := "{
<p><strong>List</strong>
</p>
<ul><li> this </li>
<li> is</li>
<li> a</li>
<li> list</li>
<li> with<ul><li> sub item</li>
<li> sub item</li>
</ul></li>
<li> end</li>
</ul>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_list_number
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
			gen: like new_xhtml_generator
		do
			create t.make_from_string ("[
'''Numbered lists'''
# list
# with
## sub item
## sub item
# end
			]")

e := "{
<p><strong>Numbered lists</strong>
</p>
<ol><li> list</li>
<li> with<ol><li> sub item</li>
<li> sub item</li>
</ol></li>
<li> end</li>
</ol>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_list_definition
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
			gen: like new_xhtml_generator
		do
			-- FIXME: does not support yet:
			--	; Term
			--	: description line 1
			--	: description line 2
			--
			-- or even with a single line.
			create t.make_from_string ("[
'''Definitions'''
; abc: first letters
; pi: Pi number
; Term: description
			]")

e := "{
<p><strong>Definitions</strong>
</p>
<dl><dt> abc</dt>
<dd> first letters</dd>
<dt> pi</dt>
<dd> Pi number</dd>
<dt> Term</dt>
<dd> description</dd>
</dl>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_list_mixed
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
			gen: like new_xhtml_generator
		do
			create t.make_from_string ("[
'''Mixed list'''
# Letters
#* a
#* b
#* c
# Misc
## sub item 1
##* bullet 1
##* bullet 2
## sub item 2
##* bullet 1
##** sub bullet 1.1
##* bullet 2
##*# sub item ..
# end
			]")

e := "{
<p><strong>Mixed list</strong>
</p>
<ol><li> Letters<ul><li> a</li>
<li> b</li>
<li> c</li>
</ul></li>
<li> Misc<ol><li> sub item 1<ul><li> bullet 1</li>
<li> bullet 2</li>
</ul></li>
<li> sub item 2<ul><li> bullet 1<ul><li> sub bullet 1.1</li>
</ul></li>
<li> bullet 2<ul><li> sub item ..</li>
</ul></li>
</ul></li>
</ol></li>
<li> end</li>
</ol>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_tag_div
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
			gen: like new_xhtml_generator
		do
			create t.make_from_string ("[
'''Test'''
<div>
'''class''' FOO [BAR]
feature
end
</div>
			]")

e := "{
<p><strong>Test</strong>
<div><strong>class</strong> FOO [BAR]
feature
end</div>
</p>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_external_link
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
			gen: like new_xhtml_generator
		do
			create t.make_from_string ("[
Test [https://eiffel.org Eiffel Community].
			]")

e := "{
<p>Test <a href="https://eiffel.org" class="wiki_ext_link">Eiffel Community</a>.
</p>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))

			create t.make_from_string ("[
Test [https://eiffel.org|Eiffel Community].
			]")

e := "{
<p>Test <a href="https://eiffel.org" class="wiki_ext_link">Eiffel Community</a>.
</p>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))

			create t.make_from_string ("[
Test [https://eiffel.org|target="blank"|foo=bar|Eiffel Community].
			]")

e := "{
<p>Test <a href="https://eiffel.org" class="wiki_ext_link" target="blank" foo=bar>Eiffel Community</a>.
</p>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))

			create t.make_from_string ("[
Test [/path-to-page a page].
			]")

e := "{
<p>Test <a href="/path-to-page" class="wiki_ext_link">a page</a>.
</p>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_bracket_text_without_url
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
			gen: like new_xhtml_generator
		do
			create t.make_from_string ("[
Test PROCEDURE [FOO] class.
			]")

e := "{
<p>Test PROCEDURE [FOO] class.
</p>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_br
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
		do
			create t.make_from_string ("[		
Tags allow you to identify a collection of breakpoints, either from the [[Breakpoint information command|breakpoints tool]] , or in the parameters of "When hits .." actions. <br/>
Any existing breakpoint can be referenced by an implicit tag with the form: ''"'''bp:'''cluster.{CLASS}.feature@index"'' (cluster is not mandatory).<br/>

{{sample|A sample breakpoint tag: "'''bp:'''elks.{LINKED_LIST}.extend@2"}}
	]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", not o.is_empty)
		end

	test_anchor_link
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
			gen: like new_xhtml_generator
		do
			create t.make_from_string ("[
test [[#anchor|anchor link]]
			]")

e := "{
<p>test <a href="#anchor" class="wiki_link">anchor link</a>
</p>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_anchor_external_link
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
			gen: like new_xhtml_generator
		do
			create t.make_from_string ("[
test [#Section_name Anchor to #Section_name]
			]")

e := "{
<p>test <a href="#Section_name" class="wiki_ext_link">Anchor to #Section_name</a>
</p>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_anchor_section_link
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
			gen: like new_xhtml_generator
		do
			create t.make_from_string ("[
* test [[#anchor|anchor link]]
* test [[#Another_anchor|Another anchor link]]
* test [[#another_anchor|Another anchor link]]
* test [[#Summer-été|Summer-été]]

== anchor ==
first test

== Another anchor ==
another

== Summer-été ==
Summer
			]")

e := "{
<ul><li> test <a href="#anchor" class="wiki_link">anchor link</a></li>
<li> test <a href="#Another_anchor" class="wiki_link">Another anchor link</a></li>
<li> test <a href="#another_anchor" class="wiki_link">Another anchor link</a></li>
<li> test <a href="#Summer-%C3%A9t%C3%A9" class="wiki_link">Summer-été</a></li>
</ul>

<a id="anchor"></a><h2>anchor</h2>
<p>first test</p>

<a id="Another_anchor"></a><h2>Another anchor</h2>
<p>another</p>

<a id="Summer-%C3%A9t%C3%A9"></a><h2>Summer-été</h2>
<p>Summer</p>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_image
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
			gen: like new_xhtml_generator
		do
			create t.make_from_string ("[
See [[Image:http://abs.path.to/image.png]]
			]")

e := "{
<p>See <img src="http://abs.path.to/image.png" border="0"/>
</p>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_image_inlined
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
			gen: like new_xhtml_generator
		do
			create t.make_from_string ("[
See [[Image:http://abs.path.to/image.png|width=100px|This is a description|This is a title]]
			]")

e := "{
<p>See <img src="http://abs.path.to/image.png" border="0" width="100px" alt="This is a description"/>
</p>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_image_details
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
			gen: like new_xhtml_generator
		do
			create t.make_from_string ("[
See [[Image:http://abs.path.to/image.png|align=right|width=100px|This is a description]]
			]")

e := "{
<p>See <div class="wiki_image" style="text-align: right"><img src="http://abs.path.to/image.png" border="0" width="100px"/><div class="wiki_caption">This is a description</div></div>
</p>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_image_details_with_alt
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
			gen: like new_xhtml_generator
		do
			create t.make_from_string ("[
See [[Image:http://abs.path.to/image.png|align=right|width=100px|alt=Alternate text|This is a description]]
			]")

e := "{
<p>See <div class="wiki_image" style="text-align: right"><img src="http://abs.path.to/image.png" border="0" width="100px" alt="Alternate text"/><div class="wiki_caption">This is a description</div></div>
</p>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_image_details_with_frame
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
			gen: like new_xhtml_generator
		do
			create t.make_from_string ("[
See [[Image:http://abs.path.to/image.png|align=right|frame|width=100px|alt=Alternate text|This is a description]]
			]")

e := "{
<p>See <div class="wiki_image wiki_frame" style="text-align: right"><img src="http://abs.path.to/image.png" border="0" width="100px" alt="Alternate text"/><div class="wiki_caption">This is a description</div></div>
</p>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_link
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
			gen: like new_xhtml_generator
		do
			create t.make_from_string ("[
See [http://www.eiffel.org/ The Eiffel web site]
			]")

e := "{
<p>See <a href="http://www.eiffel.org/" class="wiki_ext_link">The Eiffel web site</a>
</p>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

	test_unicode
		local
			txt,e32: STRING_32
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
			gen: like new_xhtml_generator
			utf: UTF_CONVERTER
		do
			txt := {STRING_32} "begin%N* Zhōng Fú 中孚 end"

			create t.make_from_string (utf.utf_32_string_to_utf_8_string_8 (txt))

e32 := {STRING_32} "{
<p>begin
</p>
<ul><li> Zhōng Fú 中孚 end</li>
</ul>

}"
e := utf.utf_32_string_to_utf_8_string_8 (e32)

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
			txt := utf.utf_8_string_8_to_string_32 (o)
			assert ("as e32", txt.same_string (e32))
		end

end
