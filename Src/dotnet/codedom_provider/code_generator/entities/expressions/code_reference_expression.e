indexing 
	description: "Common parent of all source code generators for reference expressions"
	date: "$$"
	revision: "$$"

deferred class
	CODE_REFERENCE_EXPRESSION

inherit 
	CODE_EXPRESSION

feature -- Access

	code: STRING is
			-- Will never be used because not in the Eiffel Tree.
		deferred
		end

end -- class CODE_REFERENCE_EXPRESSION

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