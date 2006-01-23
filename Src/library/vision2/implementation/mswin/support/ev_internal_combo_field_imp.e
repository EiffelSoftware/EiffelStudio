indexing
	description: "[
		Text field inside a combo-box-ex when it is
		editable. It receive all the events and forewards them.

		Note: Created by pointer from the system.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INTERNAL_COMBO_FIELD_IMP

inherit
	WEL_SINGLE_LINE_EDIT
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
			on_erase_background,
			on_set_focus,
			on_kill_focus,
			on_set_cursor,
			on_char,
			default_process_message,
			on_getdlgcode
		end

create
	make_with_combo

feature {NONE} -- Initialization

	make_with_combo (combo: EV_COMBO_BOX_IMP) is
			-- Create the text-field from `combo'.
		do
			wel_parent := combo
			make_by_pointer (combo.edit_item)
			if item /= default_pointer then
				register_current_window
				set_default_window_procedure
			end
		end

feature -- Access

	parent: EV_COMBO_BOX_IMP is
			-- Parent of `Current'.
		do
			Result ?= wel_parent
		ensure
			parent_not_void: parent /= Void
		end

feature {NONE} -- Implementation

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the left button is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_left_button_down (keys, x_pos, y_pos)
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the middle button is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_middle_button_down (keys, x_pos, y_pos)
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_right_button_down (keys, x_pos, y_pos)
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the left button is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_left_button_up (keys, x_pos, y_pos)
		end

	on_middle_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the middle button is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_middle_button_up (keys, x_pos, y_pos)
		end

	on_right_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_right_button_up (keys, x_pos, y_pos)
		end

	on_left_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is double clicked.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_left_button_double_click (keys, x_pos, y_pos)
		end

	on_middle_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is double clicked.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_middle_button_double_click (keys, x_pos, y_pos)
		end

	on_right_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is double clicked.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_right_button_double_click (keys, x_pos, y_pos)
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the mouse move.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_mouse_move (keys, x_pos, y_pos)
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- Executed when a key is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			if not (virtual_key = {WEL_VK_CONSTANTS}.vk_down or virtual_key = {WEL_VK_CONSTANTS}.vk_up) then
					-- It appears that the up and down arrows are handled slightly
					-- differently to other keys and the  default processing seems to
					-- be called. Without this fix, the key press or release actions
					-- in a combo box are called twice for these two keys. Unfortunately
					-- at the moment, I am unaware why this happens. Julian.
				parent.on_key_down (virtual_key, key_data)
			end
		end

	on_char (character_code, key_data: INTEGER) is
			-- Wm_char message
			-- Avoid an unconvenient `bip' when the user
			-- tab to another control.
		do
			if not has_focus then
				disable_default_processing
			end
		end

	on_key_up (virtual_key, key_data: INTEGER) is
			-- Executed when a key is released.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		do
			parent.on_key_up (virtual_key, key_data)
		end

	on_set_focus is
			-- Wm_setfocus message.
		do
			parent.on_set_focus
		end

	on_kill_focus is
			-- Wm_killfocus message.
		do
			parent.on_kill_focus
		end

	on_set_cursor (hit_code: INTEGER) is
			-- Wm_setcursor message.
			-- See class WEL_HT_CONSTANTS for valid `hit_code' values.
		do
			if (hit_code = ({WEL_HT_CONSTANTS}.Htnowhere) or else hit_code = ({WEL_HT_CONSTANTS}.Htclient))
				and then parent.cursor_pixmap /= Void then
				parent.internal_on_set_cursor
			end
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
			disable_default_processing
			set_message_return_value (to_lresult (1))
		end

	default_process_message (msg: INTEGER; wparam, lparam: POINTER) is
			-- Process `msg' which has not been processed by
			-- `process_message'.
		do
			if msg = ({WEL_WINDOW_CONSTANTS}.Wm_contextmenu) then
				allow_pick_and_drop
			else
				Precursor {WEL_SINGLE_LINE_EDIT} (msg, wparam, lparam)
			end
		end

	allow_pick_and_drop is
			-- Override context menu on `Current' if pick and drop
			-- should be handled instead. We must handle two cases :-
			-- 1. We are attempting to pick from `Current'.
			-- 2. We are attempting to drop from `Current'.
		do
			if parent.application_imp.pick_and_drop_source /= Void then
				disable_default_processing
			elseif parent.pebble /= Void then
				disable_default_processing
			elseif parent.override_context_menu then
				disable_default_processing
			end
			parent.enable_context_menu
		end

	on_getdlgcode is
			-- Called when window receives WM_GETDLGCODE message.
		do
			set_message_return_value (to_lresult ({WEL_DLGC_CONSTANTS}.dlgc_want_all_keys))
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




end -- class EV_INTERNAL_COMBO_FIELD_IMP

