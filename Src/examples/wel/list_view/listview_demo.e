indexing
	description: "Application class of the WEL example : List_view."
	status: "See notice at end of class."

class
	LISTVIEW_DEMO

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

end -- class LISTVIEW_DEMO

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

