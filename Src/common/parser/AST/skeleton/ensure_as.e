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
	
	clause_name (ctxt: FORMAT_CONTEXT): STRING is
			-- "ensure"
		do
			Result := "ensure"
		end;
			
	put_clause_keywords (ctxt: FORMAT_CONTEXT) is
			-- Append keyword "ensure".
		do
			ctxt.put_text_item (ti_Ensure_keyword)
		end;

end -- class ENSURE_AS
