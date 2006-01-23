indexing
	description:
		" An internal up-down control with a specific style.%
		% Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INTERNAL_UP_DOWN_CONTROL

inherit
	WEL_UP_DOWN_CONTROL
		redefine
			default_style
		end

create
	make

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
			-- No Ws_tabstop style otherwise, the focus is
			-- lost when it is its turn.
		do
			Result := Ws_visible | Ws_child | Uds_arrowkeys |
				Uds_setbuddyint | Uds_alignright
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




end -- class EV_INTERNAL_UP_DOWN_CONTROL

