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
		
	EV_SELECT_BUTTON_IMP
		undefine
			default_style,
			on_key_down
		redefine
			interface
		end

	WEL_RADIO_BUTTON
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
			enabled as is_sensitive,
			move as move_to
		undefine
			window_process_message,
			remove_command,
			set_width,
			set_height,
			on_bn_clicked,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_key_up,
			on_key_down,
			on_set_focus,
			on_kill_focus,
			on_set_cursor,
			process_notification,
			set_text,
			show,
			hide
		redefine
			on_key_down
		end
		
create
	make

feature {NONE} -- Implementation

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed
		do
			{WEL_RADIO_BUTTON} Precursor (virtual_key, key_data)
			process_tab_and_arrows_keys (virtual_key)
		end

	interface: EV_RADIO_BUTTON

end -- class EV_RADIO_BUTTON_IMP

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
--| Revision 1.20  2000/02/24 20:40:22  brendel
--| Revised.
--| Changed --| to --! for copyright notice.
--|
--| Revision 1.19  2000/02/17 02:18:47  oconnor
--| released
--|
--| Revision 1.18  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.17.10.3  2000/01/27 19:30:28  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.17.10.2  2000/01/10 19:58:50  rogers
--| Altered to comply with the major Vision2 changes. See diff for redefinitions. Added set_peer and remove_from_group which should not be called as they are not yet implemented. I am not sure if this is possible on Windows. This needs to be fixed soon.
--|
--| Revision 1.17.10.1  1999/11/24 17:30:33  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.17.6.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
