indexing
	description: "Application class of the WEL example : List_view."
	status: "See notice at end of class."
	date: ""
	revision: ""

class
	APPLICATION

inherit
	WEL_APPLICATION
		redefine
			init_application
		end

creation
	make

feature

	main_window: MAIN_WINDOW is
			-- Create the application's main window
		once
			!! Result.make
		end

	init_application is
			-- Load the common controls dll and the rich edit dll.
		do
			!! common_controls_dll.make
			!! rich_edit_dll.make
		end

	common_controls_dll: WEL_COMMON_CONTROLS_DLL

	rich_edit_dll: WEL_RICH_EDIT_DLL

end -- class APPLICATION

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
