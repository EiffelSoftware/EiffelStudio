indexing
	description: "Check box which has 3 states (on, off, indeterminate)."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CHECK_BOX_3_STATE

inherit
	WEL_CHECK_BOX
		redefine
			default_style
		end

creation
	make,
	make_by_id

feature -- Status setting

	set_indeterminate is
			-- Set the indeterminate state.
		require
			exists: exists
		do
			cwin_send_message (item, Bm_setcheck, 3, 0)
		ensure
			indeterminate: indeterminate
		end

feature -- Status report

	indeterminate: BOOLEAN is
			-- Is the state indeterminate?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Bm_getcheck, 0, 0) = 2
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Bs_auto3state
		end

invariant
	consistent_state: exists and then checked implies not indeterminate

end -- class WEL_CHECK_BOX_3_STATE


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

