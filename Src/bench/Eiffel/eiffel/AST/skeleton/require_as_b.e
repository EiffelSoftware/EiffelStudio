class REQUIRE_AS_B

inherit

	REQUIRE_AS
		redefine
			assertions
		end;

	ASSERT_LIST_AS_B
		undefine
			set, simple_put_clause_keywords
		redefine
			put_clause_keywords, assertions
		end

feature -- Property

	assertions: EIFFEL_LIST_B [TAGGED_AS_B]
 
feature {NONE} -- Implementation
	
	put_clause_keywords (ctxt: FORMAT_CONTEXT_B) is
			-- Append keywords "require" or "require else".
		do
			if ctxt.first_assertion then
				ctxt.put_text_item (ti_Require_keyword)
			else
				ctxt.put_text_item (ti_Require_keyword);
				ctxt.put_space;
				ctxt.put_text_item_without_tabs (ti_Else_keyword)
			end
		end;

end -- class REQUIRE_AS_B
