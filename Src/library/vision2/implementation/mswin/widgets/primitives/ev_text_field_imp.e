indexing
	description:
		"EiffelVision text field. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT_FIELD_IMP

inherit
	EV_TEXT_FIELD_I
		redefine
			interface,
			hide_border
		end

	EV_TEXT_COMPONENT_IMP
		redefine
			on_key_down,
			on_char,
			interface,
			initialize,
			next_dlgtabitem
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			initialize,
			set_font
		end

	WEL_SINGLE_LINE_EDIT
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			font as wel_font,
			set_font as wel_set_font,
			destroy as wel_destroy,
			shown as is_displayed,
			clip_cut as cut_selection,
			clip_copy as copy_selection,
			unselect as deselect_all,
			selection_start as wel_selection_start,
			selection_end as wel_selection_end,
			width as wel_width,
			height as wel_height,
			set_caret_position as internal_set_caret_position,
			caret_position as internal_caret_position,
			enabled as is_sensitive,
			item as wel_item,
			move as wel_move,
			x as x_position,
			y as y_position,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			text as wel_text,
			has_capture as wel_has_capture,
			text_length as wel_text_length
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
			on_key_up,
			on_set_focus,
			on_desactivate,
			on_kill_focus,
			on_set_cursor,
			wel_background_color,
			wel_foreground_color,
			show,
			hide,
			on_size,
			x_position,
			y_position,
			select_all,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message,
			on_getdlgcode
		redefine
			on_key_down,
			on_en_change,
			default_style,
			enable,
			disable,
			on_char
		end

	EV_TEXT_FIELD_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with inteface `an_interface'.
		do
			base_make (an_interface)
			wel_make (default_parent, "", 0, 0, 0, 0, 0)
		end

	initialize is
			-- Initialize `Current'.
			-- (export status {NONE})
		do
			set_default_font
			Precursor {EV_TEXT_COMPONENT_IMP}
		end

feature {EV_ANY_I} -- Status report

	text: STRING_32 is
			-- Text of `Current'
		do
			Result := wel_text
		end

feature {EV_ANY_I} -- Status setting

	hide_border is
			-- Ensure that `Current' is displayed with no border.
		do
			set_ex_style (0)
				-- The minimum size must now be reduced as there are no borders.
			ev_set_minimum_size (
				maximum_character_width * 4, internal_font_height)
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
			-- We specify the Es_autovscroll style otherwise
			-- the system beeps when we press the return key.
		do
			Result := Ws_child | Ws_visible| Ws_tabstop
					| Ws_group | Es_left | Es_autohscroll
					| Ws_clipchildren | Ws_clipsiblings
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- We check if the enter key is pressed.
			-- 13 is the number of the return key.
		local
			spin_button: EV_SPIN_BUTTON_IMP
		do
			process_tab_key (virtual_key)
			Precursor {EV_TEXT_COMPONENT_IMP} (virtual_key, key_data)
			if virtual_key = Vk_return and is_editable then
				set_caret_position (1)
				interface.return_actions.call (Void)
			end
				--| EV_SPIN_BUTTON_IMP is composed of `Current'.
				--| Therefore if `Current' is parented in an EV_SPIN_BUTTON_IMP,
				--| we must propagate the key press event.
			spin_button ?= wel_parent
			if spin_button /= Void then
				spin_button.on_key_down (virtual_key, key_data)
			end
		end

	on_char (character_code, key_data: INTEGER) is
			-- Wm_char message.
			-- Avoid an unconvenient `beep' when the user
			-- tab to another control.
		do
			Precursor {EV_TEXT_COMPONENT_IMP} (character_code, key_data)
			if not has_focus or character_code = Vk_return then
				disable_default_processing
			end
		end

	on_en_change is
			-- The user has taken an action
			-- that may have altered the text.
		do
			interface.change_actions.call (Void)
		end

	enable is
			-- Enable mouse and keyboard input.
		local
			default_colors: EV_STOCK_COLORS
		do
			create default_colors
			cwin_enable_window (wel_item, True)
			set_background_color (default_colors.Color_read_write)
		end

	disable is
			-- Disable mouse and keyboard input
		local
			default_colors: EV_STOCK_COLORS
		do
			create default_colors
			cwin_enable_window (wel_item, False)
			set_background_color (default_colors.Color_read_only)
		end

	set_font (ft: EV_FONT) is
			-- Make `ft' new font of `Current'.
		do
			Precursor {EV_FONTABLE_IMP} (ft)
			set_default_minimum_size
		end

feature {EV_SPIN_BUTTON_IMP} -- Implementation

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem.
			-- This has been redefined from EV_WIDGET_IMP as EV_SPIN_BUTTON
			-- uses an instance of EV_TEXT_FIELD internally.
		local
			l_widget: EV_WIDGET_IMP
			l_spin_button_imp: EV_SPIN_BUTTON_IMP
			l_interface: EV_WIDGET
		do
				-- Reset the start widget searched flag.
			start_widget_searched_cell.put (-1)
			l_spin_button_imp ?= wel_parent
			if l_spin_button_imp /= Void then
				l_interface := l_spin_button_imp.interface
			else
				l_interface := interface
			end
			if not previous then
				l_widget := next_tabstop_widget (l_interface, 0, False)
			else
				l_widget := next_tabstop_widget (l_interface, 1, True)
			end
			Result := l_widget.wel_item
		end

feature {NONE} -- Implementation

	interface: EV_TEXT_FIELD;

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




end -- class EV_TEXT_FIELD_IMP

