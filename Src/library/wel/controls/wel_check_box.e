note
	description: "Control that has a check box and a text."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CHECK_BOX

inherit
	WEL_BUTTON

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

	set_checked
			-- Check the button.
			--| `check' would be a better name, but ...
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Bm_setcheck, to_wparam (1), to_lparam (0))
		ensure
			checked: checked
		end

	set_unchecked
			-- Uncheck the button.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Bm_setcheck, to_wparam (0), to_lparam (0))
		ensure
			unchecked: not checked
		end

feature -- Status report

	checked: BOOLEAN
			-- Is the button checked?
		require
			exists: exists
		do
			Result := {WEL_API}.send_message_result_integer (item, Bm_getcheck,
				to_wparam (0), to_lparam (0)) = 1
		end

feature {NONE} -- Implementation

	default_style: INTEGER
			-- Default style used to create the control.
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Bs_autocheckbox
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
