class
	TEST_WIKI_TEXT

inherit
	EQA_TEST_SET

	WIKI_TEMPLATE_RESOLVER
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
end
}")
			l_expected_output := "{
<div class="wikipage"><p>begin</p>

<a name="One"></a><h1>One</h1>

<a name="one.1"></a><h2>one.1</h2>

<a name="one.2"></a><h2>one.2</h2>

<a name="one.3"></a><h2>one.3</h2>

<a name="Two"></a><h1>Two</h1>

<a name="two.1"></a><h2>two.1</h2>

<a name="two.2"></a><h2>two.2</h2>

<a name="Three"></a><h1>Three</h1>

<a name="three.1"></a><h2>three.1</h2>

<a name="three.2"></a><h2>three.2</h2>

<a name="three.3"></a><h2>three.3</h2>
<p>end</p>
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
<ol class="wiki-toc"><a name="toc"></a><span class="title">Contents</span>
	<li><a href="#One">One</a></li>
	<ol>
		<li><a href="#one.1">one.1</a></li>
		<li><a href="#one.2">one.2</a></li>
		<li><a href="#one.3">one.3</a></li>
	</ol>
	<li><a href="#Two">Two</a></li>
	<ol>
		<li><a href="#two.1">two.1</a></li>
		<li><a href="#two.2">two.2</a></li>
	</ol>
	<li><a href="#Three">Three</a></li>
	<ol>
		<li><a href="#three.1">three.1</a></li>
		<li><a href="#three.2">three.2</a></li>
		<li><a href="#three.3">three.3</a></li>
	</ol>
</ol>
</p>

<a name="One"></a><h1>One</h1>

<a name="one.1"></a><h2>one.1</h2>

<a name="one.2"></a><h2>one.2</h2>

<a name="one.3"></a><h2>one.3</h2>

<a name="Two"></a><h1>Two</h1>

<a name="two.1"></a><h2>two.1</h2>

<a name="two.2"></a><h2>two.2</h2>

<a name="Three"></a><h1>Three</h1>

<a name="three.1"></a><h2>three.1</h2>

<a name="three.2"></a><h2>three.2</h2>

<a name="three.3"></a><h2>three.3</h2>
<p>end</p>
</div>

}"

			create p.make_with_title ("Test TOC")
			p.set_text (t)

			create o.make_empty

			p.process (new_xhtml_generator (o))
			assert ("o", same_output (o, l_expected_output))
		end

	test_html
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			l_expected_output: STRING
		do
			create t.make_from_string ("=test=%N<div>toto</div>%Nend")
			l_expected_output := "[

<a name="test"></a><h1>test</h1>
<p><div>toto</div>end</p>

]"

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", same_output (o, l_expected_output))
		end

	test_paragraph
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			l_expected_output: STRING
		do
			create t.make_from_string ("This is a first line.%NThen the second line.%N%NNext paragraph, line 1.%Nline 2.%Nend.")
			l_expected_output := "[
<p>This is a first line.Then the second line.</p>
<p>Next paragraph, line 1.line 2.end.</p>

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

<a name="test"></a><h2>test</h2>
<p>Template#seealso
1= <a href="Breakpoint commands" class="wiki_link wiki_notfound">Breakpoint commands</a>, <a href="Breakpoint information command" class="wiki_link wiki_notfound">Breakpoint information command</a>  
2={{{2}}} 
3={{{3}}}
</p>

<a name="end"></a><h2>end</h2>

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

<a name="test"></a><h2>test</h2>
<p>Template#seealso
1= <a href="Breakpoint commands" class="wiki_link wiki_notfound">Breakpoint commands</a>  
2= <a href="Breakpoint information command" class="wiki_link wiki_notfound">Breakpoint information command</a>  
3={{{3}}}
</p>

<a name="end"></a><h2>end</h2>

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

<a name="test"></a><h2>test</h2>
<p>Template#Rule
name=foo
text=bar
</p>

<a name="end"></a><h2>end</h2>

]"

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", same_output (o, l_expected_output))
		end

	test_table
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
<p>begin</p>
<pre>   abc
   def
   ghi </pre><p>end</p>

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
<p>The creation procedure <code>    make (s, e: G)</code><br/>
takes ...</p>

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
			assert ("o", o.same_string ("<p>begin/this is a ''test'' with link as [[Foobar|FooBar link]]/end</p>%N"))

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
			assert ("o", o.same_string ("<p>begin/%Nthis is a ''test'' with multiple lines and links as [[Foobar|FooBar link]]%Nthis is a ''test'' with multiple lines and links as [[Foobar|FooBar link]]%Nthis is a ''test'' with multiple lines and links as [[Foobar|FooBar link]]%N/end</p>%N"))

			create t.make_from_string ("[
begin/
<nowiki>this is an inline <code>foo.bar + test</code></nowiki>
/end
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", o.same_string ("<p>begin/this is an inline &lt;code&gt;foo.bar + test&lt;/code&gt;/end</p>%N"))

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
			assert ("o", o.same_string ("<p>begin/this is a block%N&lt;code&gt;%N	class FOO%N	feature%N	end%N&lt;/code&gt;%N/end</p>%N"))

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
			assert ("o", o.same_string ("<p>begin/this is a block%N```%N	class FOO%N	feature%N	end%N```%N/end</p>%N"))

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
			assert ("o", o.same_string ("<p>begin<code lang=%"text%">class FOO%Nfeature%Nend</code><br/>%Nend</p>%N"))



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
			assert ("o", o.same_string ("<p>begin<code lang=%"eiffel%">class FOO%Nfeature%Nend</code><br/>%Nend</p>%N"))

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
			assert ("o", o.same_string ("<p>begin<code lang=%"eiffel%">class FOO &lt;foo&gt;&lt;/bar&gt;%Nfeature%Nend</code><br/>%Nend</p>%N"))

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
			assert ("o", o.same_string ("<p>begin<code lang=%"xml%">&lt;code lang=%"eiffel%"&gt;%N%Tclass FOOBAR%N&lt;/code&gt;</code><br/>%Nend</p>%N"))

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
			assert ("o", o.same_string ("<p>begin <code class=%"inline%">FOO.bar</code> end</p>%N"))
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
			assert ("o", o.same_string ("<p>begin <code class=%"inline%"> `FOO.bar' </code> end</p>%N"))
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
<p><strong>Test</strong><div><strong>class</strong> FOO [BAR]
feature
end</div></p>

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
<p>Test <a href="https://eiffel.org" class="wiki_ext_link">Eiffel Community</a>.</p>

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
<p>Test PROCEDURE [FOO] class.</p>

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
<p>test <a href="#anchor" class="wiki_link">anchor link</a></p>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e))
		end

feature {NONE} -- Implementation

	same_output (s1, s2: READABLE_STRING_8): BOOLEAN
		local
			t1, t2: STRING
			lst1, lst2: LIST [READABLE_STRING_8]
		do
			lst1 := s1.split ('%N')
			lst2 := s2.split ('%N')
			if lst1.count = lst2.count then
				Result := True
				from
					lst1.start
					lst2.start
				until
					not Result or lst1.after or lst2.after
				loop
					t1 := lst1.item
					t2 := lst2.item
					t1.right_adjust
					t2.right_adjust
					Result := t1.same_string (t2)
					lst1.forth
					lst2.forth
				end
			end
		end

	new_xhtml_generator (o: STRING): WIKI_XHTML_GENERATOR
		do
			create Result.make (o)
			Result.set_template_resolver (Current)
		end

feature -- Resolver

	content (a_template: WIKI_TEMPLATE; a_page: detachable WIKI_PAGE): detachable STRING
			-- Template content for `a_template' in the context of `a_page' if any.
		do
			if a_template.name.is_case_insensitive_equal_general ("rule") then
				Result := "Template#" + a_template.name + "%Nname={{{name}}} %Ntext={{{text}}}%N"
			else
				Result := "Template#" + a_template.name + "%N1={{{1}}} %N2={{{2}}} %N3={{{3}}}%N"
			end
		end


end
