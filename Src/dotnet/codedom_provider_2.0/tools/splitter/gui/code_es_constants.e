indexing
	description: "Objects that provide access to constants loaded from files."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ES_CONSTANTS

inherit
	CODE_ES_CONSTANTS_IMP
		redefine
			manager_icons_dir
		end

feature -- Access

	manager_icons_dir: STRING is "icons"
			-- Relative path to icons directory

end -- class CODE_ES_CONSTANTS

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