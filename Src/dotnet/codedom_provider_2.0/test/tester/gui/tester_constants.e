indexing
	description: "Objects that provide access to constants loaded from files."
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_CONSTANTS

inherit
	TESTER_CONSTANTS_IMP
		redefine
			icons_directory
		end

feature -- Access

	icons_directory: STRING is "icons"
			-- Icons directory

end -- class TESTER_CONSTANTS

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Tester
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------