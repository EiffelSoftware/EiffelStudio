class ENSURE_AS

inherit

	ASSERT_LIST_AS
		redefine
			simple_put_clause_keywords
		end

feature

	is_then: BOOLEAN is
			-- Is the assertion list an ensure then part ?
		do
			-- Do nothing
		end;

feature 
	
	simple_put_clause_keywords (ctxt: FORMAT_CONTEXT) is
			-- Append keyword "ensure".
		do
			ctxt.put_text_item (ti_Ensure_keyword);
			if is_then then
				ctxt.put_space;
            	ctxt.put_text_item_without_tabs (ti_Then_keyword)
			end
		end;

end -- class ENSURE_AS
