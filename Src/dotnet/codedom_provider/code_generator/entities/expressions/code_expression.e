indexing 
	description: "Common parent to source code generators for expressions"
	date: "$$"
	revision: "$$"

deferred class
	CODE_EXPRESSION

inherit
	CODE_ENTITY

feature -- Status Repport

	type: CODE_TYPE_REFERENCE is
			-- Type of expression
		require
			is_in_code_generation: current_state = Code_generation
		deferred
		ensure
			non_void_type: Result /= Void
		end

end -- class CODE_EXPRESSION

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