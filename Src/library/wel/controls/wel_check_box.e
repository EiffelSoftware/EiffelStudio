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

create
	make,
	make_by_id

feature -- Status setting

	set_checked is
			-- Check the button
			--| `check' would be a better name, but ...
		require
			exists: exists
		do
			cwin_send_message (item, Bm_setcheck, to_wparam (1), to_lparam (0))
		ensure
			checked: checked
		end

	set_unchecked is
			-- Uncheck the button
		require
			exists: exists
		do
			cwin_send_message (item, Bm_setcheck, to_wparam (0), to_lparam (0))
		ensure
			unchecked: not checked
		end

feature -- Status report

	checked: BOOLEAN is
			-- Is the button checked?
		require
			exists: exists
		do
			Result := cwin_send_message_result_integer (item, Bm_getcheck,
				to_wparam (0), to_lparam (0)) = 1
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Bs_autocheckbox
		end

end -- class WEL_CHECK_BOX

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

