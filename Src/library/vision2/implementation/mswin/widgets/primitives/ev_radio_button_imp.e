indexing
	description: "Eiffel Vision radio button. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RADIO_BUTTON_IMP

inherit
	EV_RADIO_BUTTON_I
		redefine
			interface
		end
		
	EV_BUTTON_IMP
		undefine
			default_style,
			on_key_down,
			on_bn_clicked,
			process_message,
			default_alignment
		redefine
			interface,
			initialize,
			update_current_push_button,
			redraw_current_push_button,
			internal_default_height
		select
			wel_make
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

	WEL_RADIO_BUTTON
		rename
			make as wel_radio_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			font as wel_font,
			set_font as wel_set_font,
			shown as is_displayed,
			destroy as wel_destroy,
			width as wel_width,
			height as wel_height,
			item as wel_item,
			enabled as is_sensitive,
			x as x_position,
			y as y_position,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			text as wel_text,
			set_text as wel_set_text,
			checked as is_selected,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			has_capture as wel_has_capture
		undefine
			make_by_id,
			remove_command,
			set_width,
			set_height,
			on_bn_clicked,
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
			on_key_up,
			on_key_down,
			on_char,
			on_set_focus,
			on_kill_focus,
			on_desactivate,
			on_set_cursor,
			on_size,
			process_notification,
			wel_set_text,
			on_show,
			on_hide,
			show,
			hide,
			x_position,
			y_position,
			wel_foreground_color,
			wel_background_color,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message
		redefine
			on_key_down,
			default_style
		end
		
create
	make

feature {NONE} -- Initalization

	initialize is
			-- Initialize `Current'.
		do
			Precursor
			set_checked
			text_alignment := default_alignment
		end			

feature -- Status setting
	
	enable_select is
			-- Set `Current' as selected.
			--| On WEL, this happens automatically in a WEL_CONTROL, but we
			--| want it to work over multiple controls (see: EV_CONTAINER).
		local
			cur: CURSOR
		do
			if radio_group /= Void then
				cur := radio_group.cursor
				from
					radio_group.start
				until
					radio_group.off
				loop
					radio_group.item.set_unchecked
					radio_group.forth
				end
				radio_group.go_to (cur)
			end
			set_checked
			select_actions.call ([])
		end

feature {NONE} -- Implementation

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed.
		do
			Precursor {WEL_RADIO_BUTTON} (virtual_key, key_data)
			process_tab_and_arrows_keys (virtual_key)
		end

	on_bn_clicked is
			-- Called when `Current' is pressed.
		do
			enable_select
		end

	default_style: INTEGER is
			-- Default style used to create the control.
		once
			Result := Ws_visible + Ws_child + Ws_tabstop + Bs_radiobutton
				+ Ws_clipchildren + Ws_clipsiblings
		end

feature {NONE} -- Implementation, focus event

	internal_default_height: INTEGER is
			-- The default minimum height of `Current' with no text.
			-- This is used in set_default_size.
		do
			Result := 12
		end

	update_current_push_button is
			-- Update the current push button
			--
			-- Current is NOT a push button so we set the current push button
			-- to be the default push button.
		local
			top_level_dialog_imp: EV_DIALOG_I
		do
			top_level_dialog_imp ?= application_imp.window_with_focus
			if top_level_dialog_imp /= Void then
				top_level_dialog_imp.set_current_push_button (top_level_dialog_imp.internal_default_push_button)
			end
		end

	redraw_current_push_button (focused_button: EV_BUTTON) is
			-- Put a bold border on the current push button and
			-- remove any bold border to the other buttons.
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_RADIO_BUTTON

end -- class EV_RADIO_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

