class ENSURE_AS_B

inherit

	ENSURE_AS
		rename
			assertions as old_assertions
		undefine
			format_assertions
		redefine
			clause_name, put_clause_keywords
		end;

	ASSERT_LIST_AS_B
		undefine
			reset
		redefine
			clause_name, put_clause_keywords
		select 
			assertions
		end
		
feature {}
	
	clause_name (ctxt: FORMAT_CONTEXT_B): STRING is
			-- "ensure" or "ensure then"
		do
			if ctxt.first_assertion then
				Result := "ensure"
			else
				Result := "ensure then"
			end
		end ;
			
	put_clause_keywords (ctxt: FORMAT_CONTEXT_B) is
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

end -- class ENSURE_AS_B
