indexing
	description: "EiffelVision label widget. Displays a text on%
				  % only one line. Mswindows implementation";
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LABEL_IMP

inherit
	EV_LABEL_I

	EV_PRIMITIVE_IMP
		redefine
			set_default_minimum_size
		end

	EV_TEXTABLE_IMP
		redefine
			set_default_minimum_size,
			set_center_alignment,
			set_right_alignment,
			set_left_alignment
		end

	EV_FONTABLE_IMP

	WEL_STATIC
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			font as wel_font,
			shown as displayed,
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
			on_key_up,
			on_key_down,
			on_set_cursor,
			show,
			hide
		redefine
			default_style,
			wel_background_color,
			wel_foreground_color,
			set_text
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Create an empty label.
		do
			make_with_text ("")
		end

	make_with_text (txt: STRING) is
			-- Create the label with `txt' as label.
		do
			wel_make (default_parent, txt, 0, 0, 0, 0, 0)
			set_font (font)
		end

feature -- Status setting

	set_center_alignment is
			-- Set text alignment of current label to center.
		do
			set_style (basic_style + Ss_center)
		end

	set_right_alignment is
			-- Set text alignment of current label to right.
		do
			set_style (basic_style + Ss_right)
		end

	set_left_alignment is
			-- Set text alignment of current label to left.
		do
			set_style (basic_style + Ss_left)
		end

	set_default_minimum_size is
		-- Resize to a default size.
		local
			fw: EV_FONT_IMP
		do
			fw ?= font.implementation
			check
				font_not_void: fw /= Void
			end
			internal_set_minimum_size (fw.string_width (text) + 10, 7 * fw.height // 4 - 2)
		end

feature -- Element change

	set_text (txt: STRING) is
			-- Set the window text
		do
			{WEL_STATIC} Precursor (txt)
			set_default_minimum_size
		end

feature {NONE} -- WEL Implementation

	basic_style: INTEGER is
			-- Basic style without any option
		do
			Result := Ws_visible + Ws_child
		end

   	default_style: INTEGER is
   			-- Default style used to create the control
   		do
 			Result := Ws_child + Ws_visible + Ss_left
 		end

	wel_background_color: WEL_COLOR_REF is
		do
			Result := background_color_imp
		end

	wel_foreground_color: WEL_COLOR_REF is
		do
			Result := foreground_color_imp
		end

feature {NONE} -- Feature that should be directly implemented by externals

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Never_called: False
			end
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Never_called: False
			end
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

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
		end

end -- class EV_LABEL_IMP

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
