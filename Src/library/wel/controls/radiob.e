indexing
	description: "Small circle with a text next to it. A bold dot within %
		%the circle indicates that the radio button has been checked."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RADIO_BUTTON

inherit
	WEL_CHECK_BOX
		redefine
			default_style
		end

creation
	make,
	make_by_id

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_tabstop +
				Bs_autoradiobutton
		end

end -- class WEL_RADIO_BUTTON

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
