indexing
	description: "Eiffel Vision toggle button. Mswindows implementation."
	status: "See notice at end of class"
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
			--| FIXME Get back to this.
			wel_make,
			make_by_id,

			default_style
		redefine
			interface
		end

	WEL_SELECTABLE_BUTTON
		rename
			make as wel_make,
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
			move_and_resize as wel_move_and_resize,
			move as wel_move,
			resize as wel_resize,
			text as wel_text,
			set_text as wel_set_text
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
			on_size,
			wel_set_text,
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
			-- Invert the value of `is_selected'.
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

--!----------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.28  2000/04/25 16:14:52  rogers
--| Parent from WEL_SELECTABLE_BUTTON is now renamed as wel_parent.
--|
--| Revision 1.27  2000/03/28 00:17:00  brendel
--| Revised `text' related features as specified by new EV_TEXTABLE_IMP.
--|
--| Revision 1.26  2000/03/22 22:57:10  brendel
--| Fixed comma's.
--|
--| Revision 1.25  2000/03/22 22:49:56  brendel
--| Fixed to have comments on a single line.
--|
--| Revision 1.24  2000/03/17 17:03:23  rogers
--| renamed
--| 	x -> x_position,
--| 	y -> y_position,
--| 	move -> wel_move,
--| 	move_and_resize -> wel_move_and_Resize,
--| 	resize -> wel_resize
--| from
--| 	WEL_SELECTABLE_BUTTON
--|
--| Revision 1.23  2000/03/09 16:25:18  brendel
--| Added 2 FIXME's at undefine clause about newly added creation procedures
--| to WEL, but it is unclear what exactly has to be done.
--|
--| Revision 1.22  2000/03/07 17:39:03  rogers
--| Undefined on_size from WEL_SELECTABLE_BUTTON as this is now inherited from
--| EV_BUTTON_IMP.
--|
--| Revision 1.21  2000/03/07 01:17:44  brendel
--| Added undefine of wel_make and make_by_id.
--|
--| Revision 1.20  2000/02/25 21:28:16  brendel
--| Formatting.
--|
--| Revision 1.19  2000/02/24 20:41:45  brendel
--| Revised.
--| Now uses WEL_SELECTABLE_BUTTON instead of calling win32 directly.
--|
--| Revision 1.18  2000/02/23 20:22:57  rogers
--| Improved comments. Removed old command association. Removed on_bn_clicked,
--| as ancestor version
--| is now used. Added interface.
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
--| Changed to comply with major Vision2 changes. see diff for redefinitions.
--| make_with_text is removed.
--| All references to item are replaced with wel_item.
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
