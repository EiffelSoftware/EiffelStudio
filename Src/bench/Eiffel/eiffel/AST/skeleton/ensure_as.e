indexing
	description	: "AST representation of an `ensure' structure."
	date		: "$Date$"
	revision	: "$Revision$"

class ENSURE_AS

inherit
	ASSERT_LIST_AS
		redefine 
			put_clause_keywords
		end

feature -- Properties

	is_then: BOOLEAN is
			-- Is the assertion list an ensure then part ?
		do
			-- Do nothing
		end

feature {NONE} -- Implementation
	
	put_clause_keywords (ctxt: FORMAT_CONTEXT) is
			-- Append keywords "ensure" or "ensure then".
		do
			ctxt.put_text_item (ti_Ensure_keyword)
			if is_then then 
				ctxt.put_space
				ctxt.put_text_item_without_tabs (ti_Then_keyword)
			end
		end

end -- class ENSURE_AS
