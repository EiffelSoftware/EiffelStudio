class REQUIRE_ELSE_AS

inherit

	REQUIRE_AS
		redefine
			is_else, clause_name, put_clause_keywords
		end

feature

	is_else: BOOLEAN is
			-- Is the assertion list a require else ?
		do
			Result := true;
		end;

feature {}
	
	clause_name (ctxt: FORMAT_CONTEXT): STRING is
			-- require or require else
		do
			if ctxt.current_class_only or else not ctxt.first_assertion then
				Result := "require else"
			else
				Result := "require"
			end
		end;
			
	put_clause_keywords (ctxt: FORMAT_CONTEXT) is
			-- Append keywords "require else".
		do
			ctxt.put_text_item (ti_Require_keyword);
			if ctxt.current_class_only or else not ctxt.first_assertion then
				ctxt.put_space;
				ctxt.put_text_item (ti_Else_keyword)
			end
		end;

end -- class REQUIRE_ELSE_AS
