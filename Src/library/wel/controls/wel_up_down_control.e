note
	description: "[
		This control is a pair of arrow buttons that the user
		can click to increment or decrement a value.

		Note: The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to
			be loaded to use this control.
		]"
	legal: "See notice at end of class."
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

create
	make,
	make_by_id

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_x, a_y, a_width, a_height, an_id: INTEGER)
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

	position: INTEGER
			-- Current position
		do
			Result := {WEL_API}.send_message_result_integer (item, Udm_getpos32, to_wparam (0), to_lparam (0))
		end

	minimum: INTEGER
			-- Minimum position
		local
			lower: INTEGER
		do
			fixme (once "lower should be an INTEGER_32")
			{WEL_API}.send_message (item, Udm_getrange32, $lower, to_lparam (0))
			Result := lower
		end

	maximum: INTEGER
			-- Maximum position
		local
			upper: INTEGER
		do
			fixme (once "upper should be an INTEGER_32")
			{WEL_API}.send_message (item, Udm_getrange32, to_wparam (0), $upper)
			Result := upper
		end

	buddy_window: WEL_WINDOW
			-- Current buddy window
		require
			exists: exists
		do
			Result := window_of_item (
				{WEL_API}.send_message_result (item, Udm_getbuddy, to_wparam (0), to_lparam (0)))
		end

feature -- Element change

	set_position (a_position: INTEGER)
			-- Set `position' with `new_position'.
		do
			{WEL_API}.send_message (item, udm_setpos32, to_wparam (0),
				to_lparam (a_position))
		end

	set_range (a_minimum, a_maximum: INTEGER)
			-- Set `minimum' and `maximum' with `a_minimum' and
			-- `a_maximum'.
		do
			{WEL_API}.send_message (item, Udm_setrange32, to_wparam (a_minimum),
				to_lparam (a_maximum))
		end

	set_buddy_window (a_window: WEL_WINDOW)
			-- Set the buddy window with `a_window'.
		require
			exists: exists
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
		do
			{WEL_API}.send_message (item, Udm_setbuddy,
				a_window.item, to_lparam (0))
		ensure
			window_set: buddy_window = a_window
		end

feature -- Status setting

	set_decimal_base
			-- Set the radix base to decimal.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Udm_setbase, to_wparam (10), to_lparam (0))
		ensure
			decimal_base: decimal_base
		end

	set_hexadecimal_base
			-- Set the radix base to hexadecimal.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Udm_setbase, to_wparam (16), to_lparam (0))
		ensure
			hexadecimal_base: hexadecimal_base
		end

feature -- Status report

	decimal_base: BOOLEAN
			-- Is the base decimal?
		require
			exists: exists
		do
			Result := {WEL_API}.send_message_result_integer (item,
				Udm_getbase, to_wparam (0), to_lparam (0)) = 10
		end

	hexadecimal_base: BOOLEAN
			-- Is the base hexadecimal?
		require
			exists: exists
		do
			Result := {WEL_API}.send_message_result_integer (item,
				Udm_getbase, to_wparam (0), to_lparam (0)) = 16
		end

feature {NONE} -- Implementation

	class_name: STRING_32
			-- Window class name to create
		once
			Result := (create {WEL_STRING}.share_from_pointer (cwin_updown_class)).string
		end

	default_style: INTEGER
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Uds_setbuddyint + Uds_alignright
		end

feature {NONE} -- Externals

	cwin_updown_class: POINTER
		external
			"C [macro <cctrl.h>] : EIF_POINTER"
		alias
			"UPDOWN_CLASS"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_UP_DOWN_CONTROL

