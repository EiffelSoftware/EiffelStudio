indexing
	description: "Objects that provide access to constants loaded from files."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_CONSTANTS

inherit
	WIZARD_CONSTANTS_IMP
		redefine
			icons_directory
		end

feature -- Access

	icons_directory: STRING is
			-- Icons directory
		local
			l_index: INTEGER
		do
			Result := (create {ARGUMENTS}).argument (0)
			l_index := Result.last_index_of ('\', Result.count)
			if l_index > 0 then
				Result.keep_head (l_index)
			else
				Result := ""
			end
			Result.append ("resources")
		end

end -- class WIZARD_CONSTANTS

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

