class ENSURE_AS_B

inherit

	ENSURE_AS
		redefine
			assertions
		end;

	ASSERT_LIST_AS_B
		undefine
			simple_put_clause_keywords
		redefine 
			assertions, put_clause_keywords
		end

feature -- Properties

	assertions: EIFFEL_LIST_B [TAGGED_AS_B]
		
feature {NONE} -- Implementation
	
	put_clause_keywords (ctxt: FORMAT_CONTEXT_B) is
			-- Append keywords "ensure" or "ensure then".
		do
			if ctxt.first_assertion then
				ctxt.put_text_item (ti_Ensure_keyword)
			else
				ctxt.put_text_item (ti_Ensure_keyword);
				ctxt.put_space;
				ctxt.put_text_item_without_tabs (ti_Then_keyword)
			end
		end;

end -- class ENSURE_AS_B
