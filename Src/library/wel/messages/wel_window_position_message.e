indexing
	description: "Information about message Wm_windowposchanged, %
		%Wm_windowposchanging. These messages are sent to a window %
		%whose size, position, or place in the Z order has changed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WINDOW_POSITION_MESSAGE

inherit
	WEL_MESSAGE_INFORMATION

create
	make

feature -- Access

	position: WEL_WINDOW_POS is
		do
			create Result.make_by_pointer (l_param)
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




end -- class WEL_WINDOW_POSITION_MESSAGE

