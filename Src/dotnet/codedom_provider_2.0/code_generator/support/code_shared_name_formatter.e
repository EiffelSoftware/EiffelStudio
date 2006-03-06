indexing
	description: "Shared instance of {NAME_FORMATTER}"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SHARED_NAME_FORMATTER

feature -- Access

	Name_formatter: CODE_NAME_FORMATTER is
			-- Name formatter
		once
			create Result
		end
		
end -- class CODE_SHARED_NAME_FORMATTER

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