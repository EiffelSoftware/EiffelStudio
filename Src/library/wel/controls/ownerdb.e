indexing
	description: "A button of which the paint operation must be defined by %
		%the developer."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_OWNER_DRAW_BUTTON

inherit
	WEL_BUTTON
		redefine
			default_style
		end

	WEL_BS_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_id

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Bs_ownerdraw
		end

end -- class WEL_OWNER_DRAW_BUTTON

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
