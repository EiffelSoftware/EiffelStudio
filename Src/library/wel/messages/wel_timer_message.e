indexing
	description: "Information about message Wm_timer which is sent after %
		%each interval specified in the `set_timer' procedure used to %
		%install a timer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TIMER_MESSAGE

inherit
	WEL_MESSAGE_INFORMATION

create
	make

feature -- Access

	id: POINTER is
			-- Timer id specified with `set_timer'.
		do
			Result := w_param
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




end -- class WEL_TIMER_MESSAGE

