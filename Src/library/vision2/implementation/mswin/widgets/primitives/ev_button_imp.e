indexing
	description: "EiffelVision push button. Mswindows implementation."
	status: "See notice at end of class"
	note: "On windows, you can only display a text or a pixmap.%N%
	%if you set both the pixmap and the text, only the%N%
	%pixmap will be displayed. On gtk, everything works%N%
	%like it is suppose to be, you have both text and%N%
	%pixmap visible."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_BUTTON_IMP

inherit
	EV_BUTTON_I
		redefine
			interface
		select
			interface
		end

	EV_PRIMITIVE_IMP
		undefine
			set_default_minimum_size
		redefine
			on_key_down,
			initialize,
			interface,
			redraw_current_push_button,
			update_current_push_button
		end
   
	EV_INTERNALLY_PROCESSED_TEXTABLE_IMP
		redefine
			set_default_minimum_size,
			align_text_center,
			align_text_left,
			align_text_right,
			interface
		end

	EV_PIXMAPABLE_IMP
		redefine
			set_pixmap,
			remove_pixmap,
			interface
		end

	EV_FONTABLE_IMP
		rename
			interface as ev_fontable_interface
		end

	WEL_BS_CONSTANTS
		export
			{NONE} all
		end

	WEL_BM_CONSTANTS
		export
			{NONE} all
		end

	WEL_BITMAP_BUTTON
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			font as wel_font,
			shown as is_displayed,
			set_font as wel_set_font,
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
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
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
			wel_background_color,
			wel_foreground_color,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message
		redefine
			default_style,
			on_bn_clicked,
			wel_set_text,
			process_message
		end

	EV_BUTTON_ACTION_SEQUENCES_IMP

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			wel_make (default_parent, "", 0, 0, 0, 0, 0)
			extra_width := 20
			text_alignment := Text_alignment_center
		end

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_PRIMITIVE_IMP}
			set_default_font
		end

feature -- Access

	extra_width: INTEGER
			-- Extra width on the size.

	is_default_push_button: BOOLEAN
			-- Is this button currently a default push button 
			-- for a particular container?

feature -- Status setting

	set_default_minimum_size is
		-- Reset `Current' to its default minimum size.
		local
			fw: EV_FONT_IMP
			w,h: INTEGER
		do
			if pixmap_imp /= Void then
				w := pixmap_imp.width + 8
				h := pixmap_imp.height + 8
			elseif not text.is_empty then
				if private_font /= Void then
					fw ?= private_font.implementation
					check
						font_not_void: fw /= Void
					end
					w := extra_width + fw.string_width (wel_text)
					h := 19 * fw.height // 9
				else
					w := extra_width + private_wel_font.string_width (wel_text)
					h := 19 * private_wel_font.height // 9
				end
			else
				w := extra_width
				h := 7
			end

				-- Finaly, we set the minimum values.
			ev_set_minimum_size (w, h)
		end

	align_text_left is
			-- Display `text' with alignment to left of `Current'.
		local
			new_style: INTEGER
		do
			new_style := clear_flag (style, Bs_center)
			new_style := clear_flag (new_style, Bs_right)
			new_style := set_flag (new_style, Bs_left)
			set_style (new_style)

			text_alignment := Text_alignment_left
			invalidate
		end

	align_text_right is
			-- Display `text' with alignment to right of `Current'.
		local
			new_style: INTEGER
		do
			new_style := clear_flag (style, Bs_center)
			new_style := clear_flag (new_style, Bs_left)
			new_style := set_flag (new_style, Bs_right)
			set_style (new_style)

			text_alignment := Text_alignment_right
			invalidate
		end

	align_text_center is
			-- -- Display `text' with alignment in center of `Current'.
		local
			new_style: INTEGER
		do
			new_style := clear_flag (style, Bs_right)
			new_style := clear_flag (new_style, Bs_left)
			new_style := set_flag (new_style, Bs_center)
			set_style (new_style)

			text_alignment := Text_alignment_center
			invalidate
		end

	enable_default_push_button is
			-- Set the style "default_push_button" of `Current'.
		do
			put_bold_border
			is_default_push_button := True
		end

	disable_default_push_button is
			-- Remove the style "default_push_button"  of `Current'. 
		do
			remove_bold_border
			is_default_push_button := False
		end

	enable_can_default is
			--| Implementation only needed for GTK
		do
			--| Do nothing as this is the default on Win32.
		end

feature -- Element change

	set_pixmap (pix: EV_PIXMAP) is
			-- Make `pix' the pixmap of `Current'.
		local
			wel_icon: WEL_ICON
			a_wel_bitmap: WEL_BITMAP
		do
			if pix /= private_pixmap then
				Precursor {EV_PIXMAPABLE_IMP} (pix)
				wel_icon := pixmap_imp.icon
				if wel_icon /= Void then
					set_icon (pixmap_imp.icon)
				else
					a_wel_bitmap := pixmap_imp.get_bitmap
					set_bitmap (a_wel_bitmap)
					a_wel_bitmap.decrement_reference
				end
				set_default_minimum_size
			end
		end

	remove_pixmap is
			-- Remove `pixmap' from `Current'.
		do
			Precursor {EV_PIXMAPABLE_IMP}
			unset_bitmap
			set_default_minimum_size
		end

	wel_set_text (txt: STRING) is
			-- Assign `txt' to `text' of `Current'.
		do
			Precursor {WEL_BITMAP_BUTTON} (txt)
			set_default_minimum_size
		end

feature {EV_ANY_I} -- Implementation

	put_bold_border is
			-- Put a bold border to the button
		do
			cwin_send_message (wel_item, Bm_setstyle, Bs_pushbutton | Bs_defpushbutton, 1)
		end

	remove_bold_border is
			-- Remove the bold border to the button
		do
			cwin_send_message (wel_item, Bm_setstyle, Bs_pushbutton, 1)
		end

feature {NONE} -- Implementation, focus event

	update_current_push_button is
			-- Update the current push button
			--
			-- Current is a push button, so we set it to be
			-- the current push button.
		local
			top_level_dialog_imp: EV_DIALOG_I
		do
			top_level_dialog_imp ?= application_imp.window_with_focus
			if top_level_dialog_imp /= Void then
				top_level_dialog_imp.set_current_push_button (interface)
			end
		end

	redraw_current_push_button (focused_button: EV_BUTTON) is
			-- Put a bold border on the default push button
		do
			if focused_button = Void or else 
				focused_button.implementation /= Current
			then
					-- Current is not the `focused_button' or there
					-- is focused button at all. In all case, we should
					-- remove our bold border.
				remove_bold_border
			else
					-- Current is the `focused_button' draw the
					-- bold border.
				put_bold_border
			end
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
			-- Default style used to create `Current'.
		do
			Result := ws_visible + ws_child + ws_group + ws_tabstop + Ws_clipchildren + Ws_clipsiblings
		end

	on_bn_clicked is
			-- `Current' has been pressed.
		do
			if select_actions_internal /= Void then
				select_actions_internal.call ([])
			end
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed.
		local
			a_dialog_imp: EV_DIALOG_IMP
		do
				-- Process Enter and Escape Key to process Default
				-- push button and default cancel button
			if virtual_key = Vk_escape or virtual_key = Vk_return then
				a_dialog_imp ?= top_level_window_imp
				if a_dialog_imp /= Void then
					a_dialog_imp.on_dialog_key_down (virtual_key)
				end
			end
				
			process_tab_key (virtual_key)
			Precursor {EV_PRIMITIVE_IMP} (virtual_key, key_data)
		end

	process_message (hwnd: POINTER; msg: INTEGER; wparam: INTEGER; lparam: INTEGER): INTEGER is
			-- Process all message plus `WM_GETDLGCODE'.
		do
			if msg = Wm_getdlgcode then
					--| We prevent here Windows to redraw the default push button by itself
					--| as we do the redrawing by ourselves.
				Result := 0
				set_default_processing (False)
			else
				Result := Precursor (hwnd, msg, wparam, lparam)
			end
		end
		
feature {NONE} -- Feature that should be directly implemented by externals

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem
		do
			Result := cwin_get_next_dlgtabitem (hdlg, hctl, previous)
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem.
		do
			Result := cwin_get_next_dlggroupitem (hdlg, hctl, previous)
		end

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normally, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normally, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
		end

feature {EV_ANY_I}

	interface: EV_BUTTON

end -- class EV_BUTTON_IMP

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

