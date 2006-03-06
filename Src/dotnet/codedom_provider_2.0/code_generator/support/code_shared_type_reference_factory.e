indexing
	description: "Shared instance of CODE_TYPE_REFERENCE_FACTORY"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SHARED_TYPE_REFERENCE_FACTORY

feature -- Access

	Type_reference_factory: CODE_TYPE_REFERENCE_FACTORY is
			-- Type reference factory
		once
			create Result
		end
		
end -- class CODE_SHARED_TYPE_REFERENCE_FACTORY

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