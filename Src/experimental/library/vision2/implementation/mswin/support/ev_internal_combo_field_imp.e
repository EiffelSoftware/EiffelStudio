note
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

	EV_WEL_TOOLTIPABLE
		redefine
			tooltip_window
		end

create
	make_with_combo

feature {NONE} -- Initialization

	make_with_combo (combo: EV_COMBO_BOX_IMP)
			-- Create the text-field from `combo'.
		do
			wel_parent := combo
			make_by_pointer (combo.edit_item)
			if item /= default_pointer then
				register_current_window
				set_default_window_procedure
			end
			align_text_left
		end

feature -- Access

	parent: EV_COMBO_BOX_IMP
			-- Parent of `Current'.
		local
			l_parent: detachable EV_COMBO_BOX_IMP
		do
			l_parent ?= wel_parent
			check l_parent /= Void end
			Result := l_parent
		end

feature -- Alignment

	text_alignment: INTEGER
			-- Current text alignment. Possible value are
			--	* Text_alignment_left
			--	* Text_alignment_right
			--	* Text_alignment_center		

	align_text_center
			-- Display text centered.
		local
			l_style: like style
		do
			l_style := clear_flag (style, ss_left | ss_right)
			l_style := l_style | ss_center
			set_style (l_style)
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_center
		end

	align_text_right
			-- Display text right aligned.
		local
			l_style: like style
		do
			l_style := clear_flag (style, ss_left | ss_center)
			l_style := l_style | ss_right
			set_style (l_style)
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_right
		end

	align_text_left
			-- Display text left aligned.
		local
			l_style: like style
		do
			l_style := clear_flag (style, ss_center | ss_right)
			l_style := l_style | ss_left
			set_style (l_style)
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_left
		end

feature {NONE} -- Implementation

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
			if not (virtual_key = {WEL_VK_CONSTANTS}.vk_down or virtual_key = {WEL_VK_CONSTANTS}.vk_up) then
					-- It appears that the up and down arrows are handled slightly
					-- differently to other keys and the  default processing seems to
					-- be called. Without this fix, the key press or release actions
					-- in a combo box are called twice for these two keys. Unfortunately
					-- at the moment, I am unaware why this happens. Julian.
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

	default_process_message (msg: INTEGER; wparam, lparam: POINTER)
			-- Process `msg' which has not been processed by
			-- `process_message'.
		do
			if msg = ({WEL_WINDOW_CONSTANTS}.Wm_contextmenu) then
				allow_pick_and_drop
			else
				Precursor {WEL_SINGLE_LINE_EDIT} (msg, wparam, lparam)
			end
		end

	allow_pick_and_drop
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

	on_getdlgcode
			-- Called when window receives WM_GETDLGCODE message.
		do
			set_message_return_value (to_lresult ({WEL_DLGC_CONSTANTS}.dlgc_want_all_keys))
		end

	tooltip_window: WEL_WINDOW
		do
			Result := Current
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










