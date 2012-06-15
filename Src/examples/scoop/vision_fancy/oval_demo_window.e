note
	description: "Window in which ovals are drawn."
	date: "$Date$"
	revision: "$Revision$"

class
	OVAL_DEMO_WINDOW

inherit
	DEMO_WIN
		rename
			fig_demo_cmd as oval_demo_cmd
		redefine
			create_interface_objects
		end

create
	make

feature {NONE} -- Init

	create_interface_objects
			-- <Precursor>
		do
			Precursor
			create oval_demo_cmd.make_in (drawing_area, stop_controller)
		end

feature -- Implementation

	oval_demo_cmd: separate OVAL_DEMO_CMD
			-- To draw ovals.

	window_title: STRING = "Ovals";
			-- Title of the window.


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


end
