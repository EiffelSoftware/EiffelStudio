class ENSURE_AS

inherit

	ASSERT_LIST_AS
		redefine
			clause_name, put_clause_keywords
		end
		

feature

	is_then: BOOLEAN is
			-- Is the assertion list an ensure then part ?
		do
			-- Do nothing
		end;

feature {}
	
	clause_name(ctxt: FORMAT_CONTEXT): STRING is
			-- "ensure" or "ensure then"
		do
			if ctxt.first_assertion then
				Result := "ensure"
			else
				Result := "ensure then"
			end
		end ;
			
	put_clause_keywords (ctxt: FORMAT_CONTEXT) is
			-- Append keywords "ensure" or "ensure then".
		do
			if ctxt.first_assertion then
				ctxt.put_text_item (ti_Ensure_keyword)
			else
				ctxt.put_text_item (ti_Ensure_keyword);
				ctxt.put_space;
				ctxt.put_text_item (ti_Then_keyword)
			end
		end;

end
