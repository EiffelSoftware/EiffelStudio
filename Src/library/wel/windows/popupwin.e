indexing
	description: "Window which can be moved outside the parent window."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_POPUP_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			default_style
		end

creation
	make_child,
	make_top

feature {NONE} -- Default creation values

	default_style: INTEGER is
			-- By default, a popup window is not visible
			-- at the creation time. `show' needs to be called.
			-- This solution avoids a bad visual effect when
			-- the children are created one by one inside
			-- the window.
		once
			Result := Ws_overlappedwindow + Ws_popup
		end

end -- class WEL_POPUP_WINDOW

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
