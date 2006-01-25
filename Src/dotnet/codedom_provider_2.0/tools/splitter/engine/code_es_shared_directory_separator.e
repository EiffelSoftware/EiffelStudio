indexing
	description: "Shared instance of `Directory_separator'"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ES_SHARED_DIRECTORY_SEPARATOR

feature -- Access

	Directory_separator: CHARACTER is
			-- Directory separator
		once
			Result := (create {OPERATING_ENVIRONMENT}).Directory_separator
		end

end -- class CODE_ES_SHARED_DIRECTORY_SEPARATOR

--+--------------------------------------------------------------------
--| eSplitter
--| Copyright (C) Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------