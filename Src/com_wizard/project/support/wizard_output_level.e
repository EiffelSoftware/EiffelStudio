indexing
	description: "Wizard output levels"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_OUTPUT_LEVEL

feature -- Access

	Output_all: INTEGER is unique
			-- Output everything
	
	Output_warnings: INTEGER is unique
			-- Output only warnings

	Output_none: INTEGER is unique
			-- Output nothing

end -- class WIZARD_OUTPUT_LEVEL

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
