class
	TEST_WIKI_TEXT_UNSUPPORTED

inherit
	EQA_TEST_SET

	TEST_WIKI_TEXT_I
		undefine
			default_create
		end

feature -- Tests

	todo_test_list_definition_2
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

			create t.make_from_string ("[
'''Definitions'''
; Term
: description line 1
: description line 2
			]")

e := "{
<p><strong>Definitions</strong>
</p>
<dl><dt> Term</dt>
<dd> description line 1</dd>
<dd> description line 2</dd>
</dl>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e)) -- FIXME: failure! see https://en.wikipedia.org/wiki/Help:List
		end

	todo_test_list_mixed_def
			-- See https://en.wikipedia.org/wiki/Help:List
		local
			t: WIKI_CONTENT_TEXT
			o: STRING
			e: STRING
			gen: like new_xhtml_generator
		do
			create t.make_from_string ("[
'''Mixed list and def'''
* Def
*; Term: description 1
*; Term2: description 2
* end
			]")

e := "{
<p><strong>Mixed list and def</strong>
</p>
<ul><li> Def</li>
<dl><dt> Term</dt>
<dd> description 1</dd>
<dt> Term</dt>
<dd> description 1</dd>
</dl>
<li> end</li>
</ul>

}"

			create o.make_empty

			gen := new_xhtml_generator (o)
			t.structure.process (gen)
			assert ("o", not o.is_empty)
			assert ("as e", o.same_string (e)) -- FAILURE !!! see https://en.wikipedia.org/wiki/Help:List
		end

end
