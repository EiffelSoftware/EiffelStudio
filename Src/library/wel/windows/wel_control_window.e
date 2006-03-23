indexing
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
			move,
			minimal_width,
			minimal_height,
			maximal_width,
			maximal_height,
			default_style,
			class_name,
			class_background,
			class_requires_icon
		end

create
	make,
	make_with_coordinates

feature {NONE} -- Intialization

	make_with_coordinates (a_parent: WEL_WINDOW; a_name: STRING_GENERAL;
			a_x, a_y, a_width, a_height: INTEGER) is
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

	font: WEL_FONT is
			-- Font with which the control is drawing its text.
		require
			exists: exists
		do
			if has_system_font then
				Result := (create {WEL_SHARED_FONTS}).system_font
			else
				create Result.make_by_pointer (
					cwin_send_message_result (item, Wm_getfont,
					default_pointer, default_pointer))
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_font (a_font: WEL_FONT) is
			-- Set `font' with `a_font'.
		require
			exists: exists
			a_font_not_void: a_font /= Void
			a_font_exists: a_font.exists
		do
			cwin_send_message (item, Wm_setfont,
				a_font.item,
				cwin_make_long (1, 0))
		ensure
			font_set: not has_system_font implies font.item = a_font.item
		end

feature -- Status report

	has_system_font: BOOLEAN is
			-- Does the control use the system font?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item, Wm_getfont,
				default_pointer, default_pointer) = default_pointer
		end

	minimal_width: INTEGER is
			-- Minimal width allowed for the window
		do
			Result := 0
		end

	minimal_height: INTEGER is
			-- Minimal height allowed for the window
		do
			Result := 0
		end

	maximal_width: INTEGER is
			-- Maximal width allowed for the window
		once
			Result := c_int_max
		end

	maximal_height: INTEGER is
			-- Maximal height allowed for the window
		once
			Result := c_int_max
		end

feature -- Basic operations

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		do
			move_and_resize_internal (a_x, a_y, a_width, a_height, repaint)
		end

	move (a_x, a_y: INTEGER) is
			-- Move the window to `a_x', `a_y' position.
		do
			cwin_set_window_pos (item, default_pointer,
				a_x, a_y, 0, 0,
				Swp_nosize | Swp_nozorder | Swp_noactivate)
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Child and visible style
		once
			Result := Ws_child | Ws_visible
		end

	class_background: WEL_BRUSH is
			-- Standard window background color
		once
			create Result.make_by_sys_color (Color_window + 1)
		end

	class_name: STRING_32 is
			-- Window class name to create
		once
			Result := "WELControlWindowClass"
		end
		
	class_requires_icon: BOOLEAN is
			-- Does `Current' require an icon to be registered?
			-- If `True' `register_class' assigns a class icon, otherwise
			-- no icon is assigned.
		do
			Result := False
		end

feature {NONE} -- Externals

	c_int_max: INTEGER is
			-- Maximum integer value
		external
			"C [macro <limits.h>]"
		alias
			"INT_MAX"
		end

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




end -- class WEL_CONTROL_WINDOW

