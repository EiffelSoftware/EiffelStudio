indexing
	description: "EiffelVision push button.%
		% Mswindows implementation."
	status: "See notice at end of class"
	date: "$$"
	revision: "$$"

class
	EV_BUTTON_IMP

inherit
	EV_BUTTON_I

	EV_PRIMITIVE_IMP
		undefine
			set_default_minimum_size
		redefine
			widget_make,
			on_key_down
		end
   
	EV_TEXTABLE_IMP
		redefine
			set_default_minimum_size,
			set_center_alignment,
			set_left_alignment,
			set_right_alignment
		end

	EV_PIXMAPABLE_IMP
		undefine
			pixmap_size_ok
		redefine
			set_pixmap,
			unset_pixmap
		end

	EV_FONTABLE_IMP

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
			set_font as wel_set_font,
			destroy as wel_destroy
		undefine
			window_process_message,
			remove_command,
			set_width,
			set_height,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_set_focus,
			on_kill_focus,
			on_key_down,
			on_key_up,
			on_set_cursor
		redefine
			default_style,
			on_bn_clicked,
			set_text
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Create the label with an empty label.
		do
			make_with_text ("")
		end

	make_with_text (txt: STRING) is
			-- Create the label with `txt' as label.
		do
			wel_make (default_parent, txt, 0, 0, 0, 0, 0)
			extra_width := 10
		end

	widget_make (an_interface: EV_WIDGET) is
			-- Creation of the widget.
		do
			set_font (font)
			{EV_PRIMITIVE_IMP} Precursor (an_interface)
		end

feature -- Access

	extra_width: INTEGER
			-- Extra width on the size

feature -- Status setting

	set_default_minimum_size is
		-- Resize to a default size.
		local
			fw: EV_FONT_IMP
			w,h: INTEGER
		do
			if pixmap_imp /= Void then
				w := extra_width + pixmap_imp.width
				h := 7 * pixmap_imp.height // 4
			elseif text /= "" then
				fw ?= font.implementation
				check
					font_not_void: fw /= Void
				end
				w := extra_width + fw.string_width (text)
				h := 7 * fw.height // 4 
			else
				w := extra_width
				h := 7
			end

			-- Finaly, we set the minimum values.
			internal_set_minimum_width (w)
			internal_set_minimum_height (h)
			if parent_imp /= Void then
				notify_change (1 + 2)
			end
		end

	set_left_alignment is
			-- Set the text of the button to left alignment.
		do
			set_style (default_style + Bs_left)
			invalidate
		end

	set_right_alignment is
			-- Set the text of the button to right alignment.
		do
			set_style(default_style + Bs_right)
			invalidate
		end
	set_center_alignment is
			-- Set the text of the button to center alignment.
		do
			set_style(default_style + Bs_center)
			invalidate
		end

feature -- Element change

	set_pixmap (pix: EV_PIXMAP) is
			-- Make `pix' the new pixmap of the widget.
		do
			{EV_PIXMAPABLE_IMP} Precursor (pix)
			set_bitmap (pixmap_imp.bitmap)
			set_default_minimum_size
		end

	unset_pixmap is
			-- Remove the pixmap from the container
		do
			{EV_PIXMAPABLE_IMP} Precursor
			unset_bitmap
			set_default_minimum_size
		end

	set_text (txt: STRING) is
			-- Set the window text
		do
			{WEL_BITMAP_BUTTON} Precursor (txt)
			set_default_minimum_size
		end

feature -- Event - command association

	add_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add 'cmd' to the list of commands to be executed
			-- the button is pressed.
		do
			add_command (Cmd_click, cmd, arg)
		end

feature -- Event -- removing command association

	remove_click_commands is	
			-- Empty the list of commands to be executed when
			-- the button is pressed.
		do
			remove_command (Cmd_click)
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		do
			Result := ws_visible + ws_child + ws_group + ws_tabstop
		end

	on_bn_clicked is
			-- When the button is pressed
		do
			execute_command (Cmd_click, Void)
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed
		do
			{EV_PRIMITIVE_IMP} Precursor (virtual_key, key_data)
			process_tab_key (virtual_key)
		end

feature {NONE} -- Feature that should be directly implemented by externals

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := cwin_get_next_dlgtabitem (hdlg, hctl, previous)
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := cwin_get_next_dlggroupitem (hdlg, hctl, previous)
		end

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

end -- class EV_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
