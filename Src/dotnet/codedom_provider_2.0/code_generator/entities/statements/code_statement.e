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
		
end -- class CODE_STATEMENT

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
