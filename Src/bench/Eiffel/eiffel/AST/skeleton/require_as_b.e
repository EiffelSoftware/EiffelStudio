class REQUIRE_AS

inherit

	ASSERT_LIST_AS
		redefine
			clause_name, put_clause_keywords
		end

feature -- Conveniences

	is_else: BOOLEAN is
			-- Is the assertion list a require else ?
		do
			-- Do nothing
		end;

feature {}
	
	clause_name (ctxt: FORMAT_CONTEXT): STRING is
			-- require or require else
		do
			if ctxt.first_assertion then
				Result := "require"
			else
				Result := "require else"
			end
		end;
			
	put_clause_keywords (ctxt: FORMAT_CONTEXT) is
			-- Append keywords "require" or "require else".
		do
			if ctxt.first_assertion then
				ctxt.put_text_item (ti_Require_keyword)
			else
				ctxt.put_text_item (ti_Require_keyword);
				ctxt.put_space;
				ctxt.put_text_item (ti_Else_keyword)
			end
		end;

end
