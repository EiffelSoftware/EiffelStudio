--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision option button, implementation interface";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_OPTION_BUTTON_I

inherit
	EV_MENU_HOLDER_I
		redefine
			add_menu_ok,
			interface
		end

	EV_BUTTON_I
		rename
	--		add_click_command as add_popup_command
		redefine
			align_text_center,
			align_text_left,
			align_text_right,
			set_text,
			interface
		end

feature -- Status setting

	clear_selection is
			-- Clear the selection by putting the `text'
			-- of the menu on the option button if there is one,
			-- otherwise the first menu item.
		deferred
		end

feature {EV_OPTION_BUTTON} -- Status report

	selected_item: EV_MENU_ITEM is
			-- which menu item is selected.
		deferred
		end

	menu: EV_MENU is
			-- The menu contained in the option button.
		deferred
		end

feature {EV_OPTION_BUTTON, EV_MENU_IMP} -- Implementation

	menu_items_array: ARRAYED_LIST [EV_MENU_ITEM_IMP]
			-- List of the children (menu_items) of the
			-- child (menu). We need it for `selected item'.

feature -- Implementation

	add_menu_ok: BOOLEAN is
			-- Can we add a menu to the Current widget?
		do
			-- We can only add one menu to the option button.
			Result := (menu = Void)
		end

	interface: EV_OPTION_BUTTON

end -- class EV_OPTION_BUTTON_I

--!-----------------------------------------------------------------------------
--! EiffelVision : library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.10  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.6.6  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.9.6.5  2000/02/02 00:05:40  oconnor
--| modifed for new menu classes
--|
--| Revision 1.9.6.4  2000/01/27 19:30:04  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.6.3  2000/01/10 19:21:44  king
--| Changed set_*_alignment to align_text_*.
--|
--| Revision 1.9.6.2  1999/12/17 18:03:19  rogers
--| Redefined interface to be of more refined type. menu is now ot type
--| EV_MENU (was EV_MENU_IMP).
--|
--| Revision 1.9.6.1  1999/11/24 17:30:12  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.2.3  1999/11/18 03:41:14  oconnor
--| rewrote press command handling to use action sequence
--|
--| Revision 1.9.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
