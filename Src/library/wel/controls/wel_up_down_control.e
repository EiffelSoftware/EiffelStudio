indexing
	description: "This control is a pair of arrow buttons that the user %
		%can click to increment or decrement a value."
	note: "The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to %
		%be loaded to use this control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_UP_DOWN_CONTROL

inherit
	WEL_BAR

	WEL_UDM_CONSTANTS
		export
			{NONE} all
		end

	WEL_UDS_CONSTANTS
		export
			{NONE} all
		end

	WEL_WINDOW_MANAGER
		export
			{NONE} all
		end

creation
	make,
	make_by_id

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_x, a_y, a_width, a_height, an_id: INTEGER) is
			-- Make an up-down control.
		require
			a_parent_not_void: a_parent /= Void
		do
			internal_window_make (a_parent, Void,
				default_style, a_x, a_y, a_width, a_height,
				an_id, default_pointer)
			id := an_id
		ensure
			exists: exists
			parent_set: parent = a_parent
			id_set: id = an_id
		end

feature -- Access

	position: INTEGER is
			-- Current position
		local
			temp: INTEGER
		do
			temp := cwin_send_message_result (item, Udm_getpos, 0, 0)	
			Result := cwin_lo_word (temp)
				-- Because we are use `Udm_getpos' and not `Udm_getpos32',
				-- we need to apply this conversion to the result in order to
				-- correctly deal with negative values. At some point, all settings and
				-- queries should use 32 bit functions.
			if Result > 32768 then
				Result := Result - 65536
			end
		end

	minimum: INTEGER is
			-- Minimum position
		local
			lower, higher: INTEGER
		do
			cwin_send_message (item, Udm_getrange32, cwel_pointer_to_integer ($lower), cwel_pointer_to_integer ($higher))
			Result := lower
		end

	maximum: INTEGER is
			-- Maximum position
		local
			lower, higher: INTEGER
		do
			cwin_send_message  (item, Udm_getrange32, cwel_pointer_to_integer ($lower), cwel_pointer_to_integer ($higher))
			Result := higher
		end

	buddy_window: WEL_WINDOW is
			-- Current buddy window
		require
			exists: exists
		do
			Result := window_of_item (cwel_integer_to_pointer (
				cwin_send_message_result (item, Udm_getbuddy, 0, 0)))
		end

feature -- Element change

	set_position (a_position: INTEGER) is
			-- Set `position' with `new_position'.
		do
			cwin_send_message (item, Udm_setpos, 0,
				cwin_make_long (a_position, 0))
		end

	set_range (a_minimum, a_maximum: INTEGER) is
			-- Set `minimum' and `maximum' with `a_minimum' and
			-- `a_maximum'.
		do
			cwin_send_message (item, Udm_setrange, 0,
				cwin_make_long (a_maximum, a_minimum))
		end

	set_buddy_window (a_window: WEL_WINDOW) is
			-- Set the buddy window with `a_window'.
		require
			exists: exists
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
		do
			cwin_send_message (item, Udm_setbuddy,
				a_window.to_integer, 0)
		ensure
			window_set: buddy_window = a_window
		end

feature -- Status setting

	set_decimal_base is
			-- Set the radix base to decimal.
		require
			exists: exists
		do
			cwin_send_message (item, Udm_setbase, 10, 0)
		ensure
			decimal_base: decimal_base
		end

	set_hexadecimal_base is
			-- Set the radix base to hexadecimal.
		require
			exists: exists
		do
			cwin_send_message (item, Udm_setbase, 16, 0)
		ensure
			hexadecimal_base: hexadecimal_base
		end

feature -- Status report

	decimal_base: BOOLEAN is
			-- Is the base decimal?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Udm_getbase, 0, 0) = 10
		end

	hexadecimal_base: BOOLEAN is
			-- Is the base hexadecimal?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Udm_getbase, 0, 0) = 16
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Window class name to create
		once
			create Result.make (0)
			Result.from_c (cwin_updown_class)
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Uds_setbuddyint + Uds_alignright
		end

feature {NONE} -- Externals

	cwin_updown_class: POINTER is
		external
			"C [macro <cctrl.h>] : EIF_POINTER"
		alias
			"UPDOWN_CLASS"
		end

end -- class WEL_UP_DOWN_CONTROL


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

