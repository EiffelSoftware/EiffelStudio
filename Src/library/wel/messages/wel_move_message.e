indexing
	description: "Information about message Wm_move which is sent after a %
		%window has been moved."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MOVE_MESSAGE

inherit
	WEL_MESSAGE_INFORMATION

create
	make

feature -- Access

	x: INTEGER is
			-- x-coordinate of the upper-left corner of the client
			-- area of the window
		do
			Result := x_position_from_lparam (l_param)
		end

	y: INTEGER is
			-- y-coordinate of the upper-left corner of the client
			-- area of the window
		do
			Result := y_position_from_lparam (l_param)
		end

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




end -- class WEL_MOVE_MESSAGE

