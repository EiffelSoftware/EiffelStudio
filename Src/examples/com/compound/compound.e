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

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-2001.
--| Modifications and extensions: copyright (C) ISE, 2001.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

