indexing
	description: "Check box which has 3 states (on, off, indeterminate)."
	legal: "See notice at end of class."
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

create
	make,
	make_by_id

feature -- Status setting

	set_indeterminate is
			-- Set the indeterminate state.
		require
			exists: exists
		do
			cwin_send_message (item, Bm_setcheck, to_wparam (3), to_lparam (0))
		ensure
			indeterminate: indeterminate
		end

feature -- Status report

	indeterminate: BOOLEAN is
			-- Is the state indeterminate?
		require
			exists: exists
		do
			Result := cwin_send_message_result_integer (item,
				Bm_getcheck, to_wparam (0), to_lparam (0)) = 2
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




end -- class WEL_CHECK_BOX_3_STATE

