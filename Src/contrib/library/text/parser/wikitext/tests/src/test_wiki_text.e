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

	test_html
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			l_expected_output: STRING
		do
			create t.make_from_string ("=test=%N<div>toto</div>%Nend")
			l_expected_output := "[

<a name="test"></a><h1>test</h1>
<div>toto</div><br/>
end
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
Template#seealso
1= <a href="Breakpoint commands" class="wiki_link wiki_notfound">Breakpoint commands</a>, <a href="Breakpoint information command" class="wiki_link wiki_notfound">Breakpoint information command</a>  
2={{{2}}} 
3={{{3}}}

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
Template#seealso
1= <a href="Breakpoint commands" class="wiki_link wiki_notfound">Breakpoint commands</a>  
2= <a href="Breakpoint information command" class="wiki_link wiki_notfound">Breakpoint information command</a>  
3={{{3}}}

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
Template#Rule
name=foo
text=bar

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

	test_code
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
		do
			create t.make_from_string ("[
<code lang="eiffel">
class FOO
feature
end
</code>
			]")

			create o.make_empty

			t.structure.process (new_xhtml_generator (o))
			assert ("o", not o.is_empty)
		end

	test_code_3backtiks
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
		do
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
			assert ("o", not o.is_empty)
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
