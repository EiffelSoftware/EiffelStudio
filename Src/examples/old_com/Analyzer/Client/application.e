indexing
	description: "Analyzer client root class";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"
	
class
	APPLICATION

inherit
	WEL_APPLICATION
		redefine
			init_application
		end

create
	make

feature

	main_window: MAIN_WINDOW is
			-- Create the application's main window
		once
			create Result.make
		end

	init_application is
			-- Load the common controls dll and the rich edit dll.
		do
			create common_controls_dll.make
			create rich_edit_dll.make
		end

	common_controls_dll: WEL_COMMON_CONTROLS_DLL

	rich_edit_dll: WEL_RICH_EDIT_DLL

end -- class APPLICATION

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
