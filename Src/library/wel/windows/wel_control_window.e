note
	description: "Window which can be used to design custom control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CONTROL_WINDOW

inherit
	WEL_FRAME_WINDOW
		rename
			make_child as make
		redefine
			move_and_resize,
			minimal_width,
			minimal_height,
			maximal_width,
			maximal_height,
			default_style,
			class_requires_icon
		end

create
	make,
	make_with_coordinates

feature {NONE} -- Intialization

	make_with_coordinates (a_parent: WEL_WINDOW; a_name: READABLE_STRING_GENERAL;
			a_x, a_y, a_width, a_height: INTEGER)
			-- Make a control using `a_parent' as parent and
			-- `a_name' as name. `a_x', `a_y', `a_width', and
			-- `a_height' are used to place and size the control
			-- at the creation.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
			a_name_not_void: a_name /= Void
		do
			register_class
			internal_window_make (a_parent, a_name, default_style,
				a_x, a_y, a_width, a_height, default_id,
				default_pointer)
		ensure
			parent_set: parent = a_parent
		end

feature -- Access

	font: WEL_FONT
			-- Font with which the control is drawing its text.
		require
			exists: exists
		do
			if has_system_font then
				Result := (create {WEL_SHARED_FONTS}).system_font
			else
				create Result.make_by_pointer (
					{WEL_API}.send_message_result (item, Wm_getfont,
					default_pointer, default_pointer))
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_font (a_font: WEL_FONT)
			-- Set `font' with `a_font'.
		require
			exists: exists
			a_font_not_void: a_font /= Void
			a_font_exists: a_font.exists
		do
			{WEL_API}.send_message (item, Wm_setfont,
				a_font.item,
				cwin_make_long (1, 0))
		ensure
			font_set: not has_system_font implies font.item = a_font.item
		end

feature -- Status report

	has_system_font: BOOLEAN
			-- Does the control use the system font?
		require
			exists: exists
		do
			Result := {WEL_API}.send_message_result (item, Wm_getfont,
				default_pointer, default_pointer) = default_pointer
		end

	minimal_width: INTEGER
			-- Minimal width allowed for the window
		do
			Result := 0
		end

	minimal_height: INTEGER
			-- Minimal height allowed for the window
		do
			Result := 0
		end

	maximal_width: INTEGER
			-- Maximal width allowed for the window
		once
			Result := c_int_max
		end

	maximal_height: INTEGER
			-- Maximal height allowed for the window
		once
			Result := c_int_max
		end

feature -- Basic operations

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN)
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		do
			move_and_resize_internal (a_x, a_y, a_width, a_height, repaint, 0)
		end

feature {NONE} -- Implementation

	default_style: INTEGER
			-- Child and visible style
		once
			Result := Ws_child | Ws_visible
		end

	class_requires_icon: BOOLEAN
			-- Does `Current' require an icon to be registered?
			-- If `True' `register_class' assigns a class icon, otherwise
			-- no icon is assigned.
		do
			Result := False
		end

feature {NONE} -- Externals

	c_int_max: INTEGER
			-- Maximum integer value
		external
			"C [macro <limits.h>]"
		alias
			"INT_MAX"
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class WEL_CONTROL_WINDOW

