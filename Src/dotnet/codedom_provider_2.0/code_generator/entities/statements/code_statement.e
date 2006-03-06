indexing
	description: "Common ancestor to all Eiffel representations of CodeDom statement"
	date: "$$"
	revision: "$$"		
	
deferred class
	CODE_STATEMENT

inherit
	CODE_ENTITY

feature -- Access

	need_dummy: BOOLEAN is
			-- Does statement requires dummy local variable?
		require
			in_code_generation: current_state = Code_generation
		deferred
		end
	
	line_pragma: CODE_LINE_PRAGMA
			-- Associated line pragma if any

feature -- Element Settings

	set_line_pragma (a_line_pragma: like line_pragma) is
			-- Set `line_pragma' with `a_pragma'.
		require
			attached_line_pragma: a_line_pragma /= Void
		do
			line_pragma := a_line_pragma
		ensure
			line_pragma_set: line_pragma = a_line_pragma
		end
	
end -- class CODE_STATEMENT

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
