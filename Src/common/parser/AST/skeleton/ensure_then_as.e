class ENSURE_THEN_AS

inherit

	ENSURE_AS
		redefine
			is_then, clause_name, put_clause_keywords
		end

feature

	is_then: BOOLEAN is
			-- Is the assertion list an "ensure then" part ?
		do
			Result := True;
		end;


feature {}
	
	clause_name (ctxt: FORMAT_CONTEXT): STRING is
			-- "ensure then"
		do
			Result := "ensure then"
		end;
			
	put_clause_keywords (ctxt: FORMAT_CONTEXT) is
			-- Append keywords "ensure then".
		do
			ctxt.put_text_item (ti_Ensure_keyword);
			ctxt.put_space;
			ctxt.put_text_item (ti_Then_keyword)
		end;

end -- class ENSURE_THEN_AS
