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
			Result := "require"
		end;
			
	put_clause_keywords (ctxt: FORMAT_CONTEXT) is
			-- Append keywords "require".
		do
			ctxt.put_text_item (ti_Require_keyword)
		end;

end -- class REQUIRE_AS
