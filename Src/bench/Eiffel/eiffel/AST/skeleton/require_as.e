indexing
	description	: "AST representation of a require statement."
	date		: "$Date$"
	revision	: "$Revision$"

class REQUIRE_AS

inherit
	ASSERT_LIST_AS
		redefine
			put_clause_keywords
		end

feature -- Properties

	is_else: BOOLEAN is
			-- Is the assertion list a require else ?
		do
			-- Do nothing
		end

feature {NONE} -- Implementation
	
	put_clause_keywords (ctxt: FORMAT_CONTEXT) is
			-- Append keywords "require" or "require else".
		do
			ctxt.put_text_item (ti_Require_keyword)
			if is_else then
				ctxt.put_space
				ctxt.put_text_item_without_tabs (ti_Else_keyword)
			end
		end

end -- class REQUIRE_AS
