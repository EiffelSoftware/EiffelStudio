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

	EV_BUTTON_IMP
		undefine
			wel_make,
			make_by_id,
			default_style,
			process_message
		redefine
			interface, wel_parent,
			redraw_current_push_button,
			update_current_push_button
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
			set_text as wel_set_text,
			set_checked as enable_select,
			set_unchecked as disable_select,
			checked as is_selected,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			has_capture as wel_has_capture
		undefine
			remove_command,
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
			on_key_down,
			on_key_up,
			on_char,
			on_set_focus,
			on_desactivate,
			on_kill_focus,
			on_set_cursor,
			on_bn_clicked,
			on_size,
			wel_set_text,
			on_show,
			on_hide,
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
			enable_select,
			disable_select
		end	

create
	make

feature -- Status setting

	enable_select is
			-- Enable `Current'.
		do
			Precursor
			select_actions.call ([])
		end

	disable_select is
			-- Disable `Current'.
		do
			Precursor
			select_actions.call ([])
		end

feature {NONE} -- Implementation, focus event

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

	interface: EV_TOGGLE_BUTTON

end -- class EV_TOGGLE_BUTTON_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.34  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.33  2001/07/14 12:16:30  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.32  2001/06/29 21:54:41  pichery
--| - Changed the behavior of the `default_push_button', we now use
--|   `current_push_button': the currently focused push button.
--| - The redrawing of the button with bold border is now done in vision2
--|   rather than by Windows itself.
--|
--| Revision 1.31  2001/06/07 23:08:17  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.14.2.13  2001/05/14 17:10:10  rogers
--| Removed toggle as not needed.
--|
--| Revision 1.14.2.12  2001/01/26 23:19:06  rogers
--| Undefined on_sys_key_down inherited from WEL.
--|
--| Revision 1.14.2.11  2001/01/09 19:08:30  rogers
--| Undefined default_process_message from WEL.
--|
--| Revision 1.14.2.10  2000/11/14 18:19:56  rogers
--| Renamed has_capture inherited from WEL as wel_has_capture.
--|
--| Revision 1.14.2.9  2000/11/06 17:55:01  rogers
--| Undefined on_sys_key_down from wel. Version from EV_WIDGET_IMP is now used.
--|
--| Revision 1.14.2.8  2000/10/11 23:39:58  raphaels
--| Added `on_desactivate' in list of undefined features from WEL.
--|
--| Revision 1.14.2.7  2000/09/05 18:22:33  rogers
--| Fixed toggle. Enable_select and disable_select were reversed.
--|
--| Revision 1.14.2.6  2000/08/08 02:50:03  manus
--| Updated inheritance with new WEL messages handling and with the fact that buttons
--| are now colorizable.
--|
--| Revision 1.14.2.5  2000/08/01 23:24:32  rogers
--| Redefined enable_select and disable_select from wel_selectable_button.
--| This allows select_actions to be called.
--|
--| Revision 1.14.2.4  2000/07/12 16:07:13  rogers
--| Undefined x_position and y_position inherited from WEL, as they are now
--| inherited from EV_WIDGET_IMP.
--|
--| Revision 1.14.2.3  2000/06/19 19:46:10  rogers
--| Removed FIXME as was no longer relevent. i.e. it had been fixed.
--| Comments, formatting.
--|
--| Revision 1.14.2.2  2000/05/09 20:48:28  king
--| Implemented to fit in with new selectable abstract classes
--|
--| Revision 1.14.2.1  2000/05/03 19:09:51  oconnor
--| mergred from HEAD
--|
--| Revision 1.29  2000/05/01 17:04:44  manus
--| Use of `wel_parent' directly without the hack of renaming into
--| `wel_window_parent'.
--|
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
