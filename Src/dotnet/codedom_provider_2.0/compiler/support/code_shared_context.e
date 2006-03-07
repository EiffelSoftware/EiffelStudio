indexing
	description: "Shared context between consumer and compiler"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SHARED_CONTEXT

feature -- Access

	Compilation_context: CODE_COMPILATION_CONTEXT is
			-- Compilation context initialized by consumer
		once
			create Result
		end
		
end -- class CODE_SHARED_CONTEXT

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