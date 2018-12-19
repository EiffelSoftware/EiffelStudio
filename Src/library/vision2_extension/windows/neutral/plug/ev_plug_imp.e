note
	description: "Widget that allows you to add a Windows as your child if you know its HANDLE."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PLUG_IMP

inherit
	EV_PLUG_I
		rename
			make as ev_make
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		rename
			make as ev_make
		redefine
			interface,
			is_shown_by_default
		end

	WEL_CONTROL
		rename
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			destroy as wel_destroy,
			item as wel_item,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			text as wel_text,
			set_text as wel_set_text,
			font as wel_font,
			set_font as wel_set_font,
			has_capture as wel_has_capture
		undefine
			set_width,
			set_height,
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_mouse_wheel,
			on_set_focus,
			on_desactivate,
			on_kill_focus,
			on_key_down,
			on_key_up,
			on_char,
			on_set_cursor,
			on_size,
			show,
			hide,
			x_position,
			y_position,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message,
			on_getdlgcode,
			on_wm_dropfiles
		end

create
	make

feature {NONE} -- Initialization

	make (a_handle: POINTER)
			-- Initialize Current assigning `wel_item' with `a_handle'.
		do
			wel_item := a_handle
			ev_make
		end

	old_make (an_interface: attached like interface)
			-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER
			-- Default style used to create `Current'.
		do
			Result := ws_visible
		end

	class_name: STRING_32
			-- Window class name to create
		once
			Result := generator
		end

	is_shown_by_default: BOOLEAN = False
			-- By default the widget is not shown by default as otherwise even if Current is not visible,
			-- the window represented by `wel_item' could become visible if it was not mark hidden to start with.

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PLUG note option: stable attribute end;

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
