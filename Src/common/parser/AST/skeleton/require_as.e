indexing
	description: 
		"AST represenation of a require else construct."
	date: "$Date$"
	revision: "$Revision $"

class
	REQUIRE_AS

inherit
	ASSERT_LIST_AS
		redefine
			process
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_require_as (Current)
		end

feature -- Properties

	is_else: BOOLEAN is
			-- Is the assertion list a require else ?
		do
			-- Do nothing
		end

--feature {NONE}
--	
--	simple_put_clause_keywords (ctxt: FORMAT_CONTEXT) is
--			-- Append keywords "require".
--		do
--			ctxt.put_text_item (ti_Require_keyword);
--			if is_else then
--				ctxt.put_space;
--				ctxt.put_text_item_without_tabs (ti_Else_keyword)
--			end
--		end

end -- class REQUIRE_AS
