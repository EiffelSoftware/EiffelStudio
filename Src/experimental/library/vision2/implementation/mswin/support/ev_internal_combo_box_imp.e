note
	description:
		" Text field inside a combo-box-ex when it is%
		% editable. All events are forewarded to the combo box.%
		%Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INTERNAL_COMBO_BOX_IMP

inherit
	WEL_COMBO_BOX
		rename
			parent as wel_parent
		redefine
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
			on_key_down,
			on_key_up,
			on_set_focus,
			on_kill_focus,
			on_set_cursor,
			on_char,
			on_erase_background,
			process_message,
			on_getdlgcode
		end

	EV_WEL_TOOLTIPABLE
		redefine
			tooltip_window
		end

	WEL_WM_CTLCOLOR_CONSTANTS
		export
			{NONE} all
		end

	EV_SHARED_GDI_OBJECTS
		export
			{NONE} all
		end

	EV_STOCK_COLORS_IMP
		export
			{NONE} all
		end

create
	make_with_combo

feature {NONE} -- Initialization

	make_with_combo (combo: EV_COMBO_BOX_IMP)
			-- Create the text-field from `combo'.
		do
			wel_parent := combo
			make_by_pointer (combo.combo_item)
			if item /= default_pointer then
				register_current_window
				set_default_window_procedure
			end
		end

feature -- Access

	parent: EV_COMBO_BOX_IMP
			-- Parent of `Current'.
		local
			l_result: detachable EV_COMBO_BOX_IMP
		do
			l_result ?= wel_parent
			check l_result /= Void end
			Result := l_result
		ensure
			parent_not_void: parent /= Void
		end

feature {NONE} -- Implementation

	--| We must propagate all the events to `parent'.

	on_left_button_down (keys, x_pos, y_pos: INTEGER)
			-- Executed when the left button is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.increment_level
			parent.on_left_button_down (keys, x_pos, y_pos)
			if parent.has_return_value then
				set_message_return_value (parent.message_return_value)
			end
			if not parent.default_processing then
				disable_default_processing
			end
			parent.decrement_level
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER)
			-- Executed when the middle button is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.increment_level
			parent.on_middle_button_down (keys, x_pos, y_pos)
			if parent.has_return_value then
				set_message_return_value (parent.message_return_value)
			end
			if not parent.default_processing then
				disable_default_processing
			end
			parent.decrement_level
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER)
			-- Executed when the right button is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.increment_level
			parent.on_right_button_down (keys, x_pos, y_pos)
			if parent.has_return_value then
				set_message_return_value (parent.message_return_value)
			end
			if not parent.default_processing then
				disable_default_processing
			end
			parent.decrement_level
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER)
			-- Executed when the left button is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.increment_level
			parent.on_left_button_up (keys, x_pos, y_pos)
			if parent.has_return_value then
				set_message_return_value (parent.message_return_value)
			end
			if not parent.default_processing then
				disable_default_processing
			end
			parent.decrement_level
		end

	on_middle_button_up (keys, x_pos, y_pos: INTEGER)
			-- Executed when the middle button is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.increment_level
			parent.on_middle_button_up (keys, x_pos, y_pos)
			if parent.has_return_value then
				set_message_return_value (parent.message_return_value)
			end
			if not parent.default_processing then
				disable_default_processing
			end
			parent.decrement_level
		end

	on_right_button_up (keys, x_pos, y_pos: INTEGER)
			-- Executed when the right button is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.increment_level
			parent.on_right_button_up (keys, x_pos, y_pos)
			if parent.has_return_value then
				set_message_return_value (parent.message_return_value)
			end
			if not parent.default_processing then
				disable_default_processing
			end
			parent.decrement_level
		end

	on_left_button_double_click (keys, x_pos, y_pos: INTEGER)
			-- Executed when the right button is double clicked.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.increment_level
			parent.on_left_button_double_click (keys, x_pos, y_pos)
			if parent.has_return_value then
				set_message_return_value (parent.message_return_value)
			end
			if not parent.default_processing then
				disable_default_processing
			end
			parent.decrement_level
		end

	on_middle_button_double_click (keys, x_pos, y_pos: INTEGER)
			-- Executed when the right button is double clicked.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.increment_level
			parent.on_middle_button_double_click (keys, x_pos, y_pos)
			if parent.has_return_value then
				set_message_return_value (parent.message_return_value)
			end
			if not parent.default_processing then
				disable_default_processing
			end
			parent.decrement_level
		end

	on_right_button_double_click (keys, x_pos, y_pos: INTEGER)
			-- Executed when the right button is double clicked.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.increment_level
			parent.on_right_button_double_click (keys, x_pos, y_pos)
			if parent.has_return_value then
				set_message_return_value (parent.message_return_value)
			end
			if not parent.default_processing then
				disable_default_processing
			end
			parent.decrement_level
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER)
			-- Executed when the mouse move.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.increment_level
			parent.on_mouse_move (keys, x_pos, y_pos)
			if parent.has_return_value then
				set_message_return_value (parent.message_return_value)
			end
			if not parent.default_processing then
				disable_default_processing
			end
			parent.decrement_level
		end

	on_key_down (virtual_key, key_data: INTEGER)
			-- Executed when a key is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.increment_level
			parent.on_key_down (virtual_key, key_data)
			if parent.has_return_value then
				set_message_return_value (parent.message_return_value)
			end
			if not parent.default_processing then
				disable_default_processing
			end
			parent.decrement_level
		end

	on_char (character_code, key_data: INTEGER)
			-- Wm_char message
			-- Avoid an unconvenient `bip' when the user
			-- tab to another control.
		do
			parent.increment_level
			parent.on_char (character_code, key_data)
			if parent.has_return_value then
				set_message_return_value (parent.message_return_value)
			end
			if not parent.default_processing then
				disable_default_processing
			end
			parent.decrement_level
		end

	on_key_up (virtual_key, key_data: INTEGER)
			-- Executed when a key is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.increment_level
			parent.on_key_up (virtual_key, key_data)
			if parent.has_return_value then
				set_message_return_value (parent.message_return_value)
			end
			if not parent.default_processing then
				disable_default_processing
			end
			parent.decrement_level
		end

	on_set_focus
			-- Wm_setfocus message.
		do
			parent.increment_level
			parent.on_set_focus
			if parent.has_return_value then
				set_message_return_value (parent.message_return_value)
			end
			if not parent.default_processing then
				disable_default_processing
			end
			parent.decrement_level
		end

	on_kill_focus
			-- Wm_killfocus message.
		do
			if not parent.is_editable then
				parent.increment_level
				parent.on_kill_focus
				if parent.has_return_value then
					set_message_return_value (parent.message_return_value)
				end
				if not parent.default_processing then
					disable_default_processing
				end
				parent.decrement_level
			end
		end

	on_set_cursor (hit_code: INTEGER)
			-- Wm_setcursor message.
			-- See class WEL_HT_CONSTANTS for valid `hit_code' values.
		do
			if
				(hit_code = ({WEL_HT_CONSTANTS}.Htnowhere) or else
				hit_code = ({WEL_HT_CONSTANTS}.Htclient)) and then
				parent.cursor_pixmap /= Void
			then
				parent.internal_on_set_cursor
			end
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
			disable_default_processing
			set_message_return_value (to_lresult (1))
		end

	cwin_get_wm_command_hwnd (wparam, lparam: POINTER): POINTER
		external
			"C [macro <winx.h>] (WPARAM, LPARAM): EIF_POINTER"
		alias
			"GET_WM_COMMAND_HWND"
		end

	on_wm_ctlcolor (wparam, lparam: POINTER)
			-- Common routine for Wm_ctlcolor messages.
		require
			exists: exists
		local
			control: detachable WEL_COLOR_CONTROL
			hwnd_control: POINTER
			paint_dc: WEL_PAINT_DC
		do
			hwnd_control := cwin_get_wm_command_hwnd (wparam, lparam)
			if hwnd_control /= default_pointer then
				control ?= window_of_item (hwnd_control)
				if control /= Void and then control.exists then
					create paint_dc.make_by_pointer (Current, wparam)
					on_color_control (control, paint_dc)
				end
			end
		end

	on_color_control (control: WEL_COLOR_CONTROL; paint_dc: WEL_PAINT_DC)
			-- Wm_ctlcolorstatic, Wm_ctlcoloredit, Wm_ctlcolorlistbox
			-- and Wm_ctlcolorscrollbar messages.
			-- To change its default colors, the color-control `control'
			-- needs :
			-- 1. a background color and a foreground color to be selected
			--    in the `paint_dc',
			-- 2. a backgound brush to be returned to the system.
		local
			brush: WEL_BRUSH
			int: detachable EV_INTERNAL_COMBO_FIELD_IMP
			w: detachable EV_COMBO_BOX_IMP
			background_color: detachable EV_COLOR_IMP
			foreground_color: detachable EV_COLOR_IMP

		do
			int ?= control
			check int /= Void end
			w ?= int.parent
			check
				is_a_combo_box: w /= Void
			end
			if w.background_color_imp /= Void or
				w.foreground_color_imp /= Void
			then
					-- Not the default color, we need to do something here
					-- to apply `background_color' to `control'.
				background_color ?= w.background_color.implementation
				foreground_color ?= w.foreground_color.implementation
				check background_color /= Void end
				check foreground_color /= Void end
				paint_dc.set_text_color (foreground_color)
				paint_dc.set_background_color (background_color)
				brush := allocated_brushes.get (Void, background_color)
				debug ("WEL")
					io.put_string ("Warning, there is no `decrement_reference'%Nfor the previous brush%N")
				end
				set_message_return_value (brush.item)
				disable_default_processing
			end
		end

	process_message (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER
			-- Call the routine `on_*' corresponding to the
			-- message `msg'.
		do
			inspect msg
			when wm_ctlcoloredit then
				on_wm_ctlcolor (wparam, lparam)
			else
				Result := Precursor {WEL_COMBO_BOX} (hwnd, msg, wparam, lparam)
			end
		end

	on_getdlgcode
			-- Called when window receives WM_GETDLGCODE message.
		do
			set_message_return_value (to_lresult ({WEL_DLGC_CONSTANTS}.dlgc_want_all_keys))
		end

	tooltip_window: WEL_WINDOW
		do
			Result := Current
		end

feature {NONE} -- Implementation

	default_style: INTEGER
			-- Default style of `Current'.
			-- This is deferred from WEL_WINDOW but is not needed in `Current'
			-- so implemented to return 0.
		do
			Result := 0
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

end











