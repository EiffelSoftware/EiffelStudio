indexing
	description: "Shared instance of {WIZARD_PROFILE_MANAGER}"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SHARED_PROFILE_MANAGER

feature -- Access

	Profile_manager: WIZARD_PROFILE_MANAGER is
			-- Shared instance of {WIZARD_PROFILE_MANAGER}
		once
			create Result.make
		end
		
end -- class WIZARD_SHARED_PROCESS_MANAGER

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

