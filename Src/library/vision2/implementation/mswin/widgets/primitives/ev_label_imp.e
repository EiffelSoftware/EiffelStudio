--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
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
		redefine
			interface
		select
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			set_default_minimum_size,
			interface,
			initialize
		end

	EV_TEXTABLE_IMP
		undefine
			set_default_minimum_size
		redefine
			set_default_minimum_size,
			align_text_center,
			align_text_left,
			align_text_right,
			interface
		end

	EV_FONTABLE_IMP
		rename
			interface as ev_fontable_imp_interface
		end

	WEL_STATIC
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			font as wel_font,
			shown as is_displayed,
			set_font as wel_set_font,
			destroy as wel_destroy,
			width as wel_width,
			height as wel_height,
			enabled as is_sensitive,
			item as wel_item,
			move as move_to
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
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create an empty label.
		do
			base_make (an_interface)
			wel_make (default_parent, "", 0, 0, 0, 0, 0)
		end

	
	initialize is
			-- Initialize label.
		do
			{EV_PRIMITIVE_IMP} Precursor
			set_font (font)
		end

feature -- Status setting

	align_text_center is
			-- Set text alignment of current label to center.
		do
			set_style (basic_style + Ss_center)
			invalidate
		end

	align_text_right is
			-- Set text alignment of current label to right.
		do
			set_style (basic_style + Ss_right)
			invalidate
		end

	align_text_left is
			-- Set text alignment of current label to left.
		do
			set_style (basic_style + Ss_left)
			invalidate
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

feature {EV_ANY_I}

	interface: EV_LABEL

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.29  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.28.6.6  2000/02/01 03:34:57  brendel
--| Removed undefine of set_default_minimum_size.
--|
--| Revision 1.28.6.5  2000/01/27 19:30:27  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.28.6.4  2000/01/19 23:55:54  rogers
--| renamed interface inherited from EV_FONTABLE_IMP as ev_fontable_interface, and selected interface from EV_LABEL_I.
--|
--| Revision 1.28.6.3  2000/01/11 23:33:48  rogers
--| Modified to comply with the major Vision2 changes. See diff for re-definitions. renamed set_******_alignment to align_text_******.
--|
--| Revision 1.28.6.2  1999/12/17 00:39:19  rogers
--| Altered to fit in with the review branch. Basic alterations, make now takes an interface.
--|
--| Revision 1.28.6.1  1999/11/24 17:30:32  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.28.2.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
