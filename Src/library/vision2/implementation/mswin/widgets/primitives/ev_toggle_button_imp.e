--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision Toggle button.%
				% Mswindows implementation"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOGGLE_BUTTON_IMP

inherit
	EV_TOGGLE_BUTTON_I
		redefine
			interface
		end

	EV_SELECT_BUTTON_IMP
		undefine
			default_style
		redefine
			interface
		end

	WEL_SELECTABLE_BUTTON
		rename
			make as wel_make,
			parent as wel_window_parent,
			set_parent as wel_set_parent,
			font as wel_font,
			set_font as wel_set_font,
			shown as is_displayed,
			destroy as wel_destroy,
			width as wel_width,
			height as wel_height,
			text as wel_text,
			item as wel_item,
			move as move_to,
			enabled as is_sensitive
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
			on_key_down,
			on_key_up,
			on_set_focus,
			on_kill_focus,
			on_set_cursor,
			on_bn_clicked,
			set_text,
			show,
			hide
		end	

create
	make

feature -- Status setting

	disable_select is
			-- Set `is_selected' `False'.
		do
			set_unchecked
		end

	toggle is
			-- Change `is_selected'.
		do
			if checked then
				set_unchecked
			else
				set_checked
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOGGLE_BUTTON

end -- class EV_TOGGLE_BUTTON_IMP

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
--| Revision 1.19  2000/02/24 20:41:45  brendel
--| Revised.
--| Now uses WEL_SELECTABLE_BUTTON instead of calling win32 directly.
--|
--| Revision 1.18  2000/02/23 20:22:57  rogers
--| Improved comments. Removed old command association. Removed on_bn_clicked, as ancestor version is now used. Added interface.
--|
--| Revision 1.17  2000/02/19 06:34:13  oconnor
--| removed old command stuff
--|
--| Revision 1.16  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.15  2000/02/14 11:40:45  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.14.4.5  2000/02/08 07:21:03  brendel
--| Minor changes to run through compiler.
--| Still needs major revision.
--|
--| Revision 1.14.4.4  2000/01/27 19:30:30  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.14.4.3  2000/01/27 00:35:41  rogers
--| Commented out old command execution.
--|
--| Revision 1.14.4.2  2000/01/10 19:03:36  rogers
--| Changed to comply with major Vision2 changes. see diff for redefinitions. make_with_text is removed. All references to item are replaced with wel_item.
--|
--| Revision 1.14.4.1  1999/11/24 17:30:35  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.12.6.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
