indexing
	description	: "Scroll bar arrows (ESB) constants.%
				  %used in message SBM_ENABLE_ARROWS"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_ESB_CONSTANTS

feature -- Constants

	Esb_disable_both: INTEGER is 3
			-- Disables both arrows on a scroll bar.

	Esb_disable_down: INTEGER is 2
			-- Disables the down arrow on a vertical scroll bar.

	Esb_disable_ltup: INTEGER is 1
			-- Disables the left arrow on a horizontal scroll bar 
			-- or the up arrow on a vertical scroll bar.

	Esb_disable_left: INTEGER is 1
			-- Disables the left arrow on a horizontal scroll bar.

	Esb_disable_rtdn: INTEGER is 2
			-- Disables the right arrow on a horizontal scroll bar 
			-- or the down arrow on a vertical scroll bar.

	Esb_disable_up: INTEGER is 1
			-- Disables the up arrow on a vertical scroll bar.

	Esb_enable_both: INTEGER is 0;
			-- Enables both arrows on a scroll bar.

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




end -- class WEL_ESB_CONSTANTS

