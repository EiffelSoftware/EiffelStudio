indexing
	description:
		" An internal up-down control with a specific style.%
		% Mswindows implementation."
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
			Result := Ws_visible + Ws_child + Uds_arrowkeys 
				 + Uds_setbuddyint + Uds_alignright
		end

end -- class EV_INTERNAL_UP_DOWN_CONTROL

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

