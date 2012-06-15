note
	description: "Window in which ovals are drawn."
	date: "$Date$"
	revision: "$Revision$"

class
	RECTANGLE_DEMO_WINDOW

inherit
	DEMO_WIN
		rename
			fig_demo_cmd as rect_demo_cmd
		redefine
			create_interface_objects
		end

create
	make

feature {NONE} -- Initialization

	create_interface_objects
			-- <Precursor>
		do
			Precursor
			create rect_demo_cmd.make_in (drawing_area, stop_controller)
		end

feature -- Implementation

	rect_demo_cmd: separate RECTANGLE_DEMO_CMD
			-- To draw rectangles.

	window_title: STRING = "Rectangles";
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
