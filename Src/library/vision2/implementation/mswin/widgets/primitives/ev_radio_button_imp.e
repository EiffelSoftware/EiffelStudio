note
	description: "Eiffel Vision radio button. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			on_bn_clicked,
			process_message,
			default_alignment,
			on_erase_background,
			background_brush,
			on_wm_theme_changed
		redefine
			interface,
			make,
			update_current_push_button,
			internal_default_height,
			set_default_minimum_size,
			set_background_color,
			fire_select_actions_on_enter,
			process_navigation_key
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
			on_mouse_wheel,
			on_key_up,
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
			default_process_message,
			on_getdlgcode,
			on_wm_dropfiles,
			on_key_down
		redefine
			default_style,
			on_erase_background
		end

create
	make

feature {NONE} -- Initalization

	make
			-- Initialize `Current'.
		do
			Precursor
			set_checked
			text_alignment := default_alignment
		end

feature -- Status setting

	set_default_minimum_size
			-- Reset `Current' to its default minimum size.
		do
				-- This extra width only needs to be added if
				-- we are using a large font, hence we do nothing
				-- with the system font.
 			if not has_system_font and not text.is_empty then
 				if attached private_font as l_private_font then
 					extra_width := 20 + l_private_font.implementation.height // 2
 				elseif attached private_wel_font as l_private_wel_font then
 					extra_width := 20 + l_private_wel_font.height // 2
 				else
 					check False end
 				end
 			end
			Precursor {EV_BUTTON_IMP}
		end

	enable_select
			-- Set `Current' as selected.
			--| On WEL, this happens automatically in a WEL_CONTROL, but we
			--| want it to work over multiple controls (see: EV_CONTAINER).
		local
			cur: CURSOR
			l_radio_group: like radio_group
		do
			l_radio_group := radio_group
			if l_radio_group /= Void then
				cur := l_radio_group.cursor
				from
					l_radio_group.start
				until
					l_radio_group.off
				loop
					l_radio_group.item.set_unchecked
					l_radio_group.forth
				end
				l_radio_group.go_to (cur)
			end
			set_checked
			if select_actions_internal /= Void then
				select_actions.call (Void)
			end
		end

feature {NONE} -- Implementation

	on_bn_clicked
			-- Called when `Current' is pressed.
		do
			enable_select
		end

	default_style: INTEGER
			-- Default style used to create the control.
		once
			Result := Ws_visible | Ws_child | Ws_tabstop | Bs_radiobutton
				| Ws_clipchildren | Ws_clipsiblings
		end

feature {NONE} -- Feature that should be directly implemented by externals

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER
			-- Encapsulation of the SDK GetNextDlgGroupItem.
		local
			l_cur: CURSOR
		do
			if attached radio_group as l_radio_group then
				l_cur := l_radio_group.cursor
				l_radio_group.start
				l_radio_group.search (Current)
				check
					radio_group_not_off: not l_radio_group.off
				end
				if previous then
					l_radio_group.forth
					if l_radio_group.off then
						Result := l_radio_group.first.wel_item
					else
						Result := l_radio_group.item.wel_item
					end
				else
					l_radio_group.back
					if l_radio_group.off then
						Result := l_radio_group.last.wel_item
					else
						Result := l_radio_group.item.wel_item
					end
				end
				l_radio_group.go_to (l_cur)
			else
				Result := cwin_get_next_dlggroupitem (hdlg, hctl, previous)
			end
		end

feature {NONE} -- Implementation, focus event

	process_navigation_key (virtual_key: INTEGER)
			-- Process a tab or arrow key press to give the focus to the next
			-- widget. Need to be called in the feature on_key_down when the
			-- control need to process this kind of keys.
		do
			inspect
				virtual_key
			when {WEL_INPUT_CONSTANTS}.vk_down, {WEL_INPUT_CONSTANTS}.vk_right then
				arrow_action (True)
			when {WEL_INPUT_CONSTANTS}.vk_up, {WEL_INPUT_CONSTANTS}.vk_left then
				arrow_action (False)
			else
				Precursor (virtual_key)
			end
		end

	arrow_action (direction: BOOLEAN)
			-- Go to the next widget that takes the focus throughthe arrow
			-- keys. If `direction' it goes to the next widget otherwise,
			-- it goes to the previous one.
		local
			hwnd, l_null: POINTER
			window: detachable WEL_WINDOW
			l_top: like top_level_window_imp
		do
			l_top := top_level_window_imp
			if l_top /= Void then
				hwnd := next_dlggroupitem (l_top.wel_item, wel_item, direction)
			end
			if hwnd /= l_null then
				window := window_of_item (hwnd)
				if window /= Void then
					window.set_focus
				end
			end
		end

	internal_default_height: INTEGER
			-- The default minimum height of `Current' with no text.
			-- This is used in set_default_size.
		do
				--|FIXME As soon as we find a nice way to
				--| know how large the check part of `Current'
				--| will be drawn by Windows, we can query this directly.
			Result := 12
		end

	update_current_push_button
			-- Update the current push button
			--
			-- Current is NOT a push button so we set the current push button
			-- to be the default push button.
		local
			top_level_dialog_imp: detachable EV_DIALOG_I
		do
			top_level_dialog_imp ?= application_imp.window_with_focus
			if top_level_dialog_imp /= Void then
				top_level_dialog_imp.set_current_push_button (top_level_dialog_imp.internal_default_push_button)
			end
		end

	fire_select_actions_on_enter
			-- Call select_actions to respond to Enter key press if
			-- Current supports it.
		do
		end

	set_background_color (color: EV_COLOR)
			-- Make `color' the new `background_color'
		do
			background_color_imp ?= color.implementation
			if is_displayed then
				-- If the widget is not hidden then invalidate.
				invalidate
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

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_RADIO_BUTTON note option: stable attribute end;

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

end -- class EV_RADIO_BUTTON_IMP
