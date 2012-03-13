note
	description: "Application root class which creates first window and launch the event loop."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	WEL_APPLICATION
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			create_interface_objects
			Precursor
		end

feature -- Access

	main_window: MAIN_WINDOW
			-- Create the application's main window
		once
			create Result.make
		end

feature -- Initialization

	create_interface_objects
			-- Load the common controls dll
		do
			create common_controls_dll.make
		end

	common_controls_dll: WEL_COMMON_CONTROLS_DLL;

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end -- class APPLICATION

