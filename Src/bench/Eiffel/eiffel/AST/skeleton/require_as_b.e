class REQUIRE_AS_B

inherit

	REQUIRE_AS
		rename
			assertions as old_assertions
		undefine
			clause_name, put_clause_keywords,
			reset, format_assertions
		end;

	ASSERT_LIST_AS_B
		redefine
			clause_name, put_clause_keywords
		select
			assertions
		end

feature {}
	
	clause_name (ctxt: FORMAT_CONTEXT_B): STRING is
			-- require or require else
		do
			if ctxt.first_assertion then
				Result := "require"
			else
				Result := "require else"
			end
		end;
			
	put_clause_keywords (ctxt: FORMAT_CONTEXT_B) is
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

end -- class REQUIRE_AS_B
