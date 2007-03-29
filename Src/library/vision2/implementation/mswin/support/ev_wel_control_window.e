indexing
	description: ""
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WEL_CONTROL_WINDOW

inherit
	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			font as wel_font,
			set_font as wel_set_font,
			destroy as wel_destroy,
			width as wel_width,
			height as wel_height,
			enabled as is_sensitive,
			item as wel_item,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			x as x_position,
			y as y_position,
			has_capture as wel_has_capture
		undefine
			set_width,
			set_height,
			on_mouse_move,
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_key_up,
			on_mouse_wheel,
			on_set_focus,
			on_kill_focus,
			on_desactivate,
			on_set_cursor,
			on_paint,
			on_key_down,
			on_char,
			show,
			hide,
			on_size,
			x_position,
			y_position,
			on_sys_key_up,
			default_process_message
		redefine
			class_name
		end

feature {NONE} -- Implementation

	class_name: STRING_32 is
			-- Window class name to create
		do
			Result := generator
		end

	cwin_get_next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- SDK GetNextDlgGroupItem
		external
			"C [macro <wel.h>] (HWND, HWND, BOOL): HWND"
		alias
			"GetNextDlgTabItem"
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




end -- class EV_WEL_CONTROL_WINDOW

