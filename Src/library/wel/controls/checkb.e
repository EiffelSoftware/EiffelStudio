indexing
	description: "Control that has a check box and a text."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CHECK_BOX

inherit
	WEL_BUTTON
		redefine
			default_style
		end

	WEL_BM_CONSTANTS
		export
			{NONE} all
		end

	WEL_BS_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_id

feature -- Status setting

	set_checked is
			-- Check the button
			--| `check' would be a better name, but ...
		require
			exists: exists
		do
			cwin_send_message (item, Bm_setcheck, 1, 0)
		ensure
			checked: checked
		end

	set_unchecked is
			-- Uncheck the button
		require
			exists: exists
		do
			cwin_send_message (item, Bm_setcheck, 0, 0)
		ensure
			unchecked: not checked
		end

feature -- Status report

	checked: BOOLEAN is
			-- Is the button checked?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Bm_getcheck, 0, 0) = 1
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Bs_autocheckbox
		end

end -- class WEL_CHECK_BOX

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
