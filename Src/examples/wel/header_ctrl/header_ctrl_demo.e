indexing
	description: "Application class of the WEL example : Header_Control."
	status: "See notice at end of class."

class
	HEADER_CTRL_DEMO

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
		end

	common_controls_dll: WEL_COMMON_CONTROLS_DLL

end -- class HEADER_CTRL_DEMO

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
