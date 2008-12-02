indexing
	description: "Window in which ovals are drawn."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OVAL_DEMO_WINDOW

inherit
	DEMO_WIN
		rename
			fig_demo_cmd as oval_demo_cmd
		end

create
	make

feature -- Implementation
	
	launch_demo is
		do
			create oval_demo_cmd.make_in (client_window, display_mutex)
			oval_demo_cmd.launch
		end

	oval_demo_cmd: OVAL_DEMO_CMD
			-- To draw ovals.

	title: STRING is "Ovals";
			-- Title of the window.
		

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


end -- class OVAL_DEMO_WINDOW

