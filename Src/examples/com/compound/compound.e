indexing
	description: "Root class for compound file viewer";
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMPOUND_FILE_VIEWER
	
inherit
	WEL_APPLICATION
		redefine
			init_application
		end

creation
	make

feature -- Access
		
	main_window: MAIN_WINDOW is
			-- Application's main window
		once
			create Result.make
		end

	rich_edit_dll: WEL_RICH_EDIT_DLL
			-- Rich edit dll
			
feature {NONE} -- Implementation

	init_application is
			-- Load Rich Edit dll
		do
			create rich_edit_dll.make
		end

end -- class APPLICATION

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, ISE building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
