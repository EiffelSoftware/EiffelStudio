indexing
	description: "Application class of the WEL example : Header_Control."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	HEADER_CTRL_DEMO

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
		end

	common_controls_dll: WEL_COMMON_CONTROLS_DLL;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class HEADER_CTRL_DEMO

