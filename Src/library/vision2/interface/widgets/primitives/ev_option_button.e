--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"Eiffel Vision option button. is a button that%
		% displays a popup_menu when we click on it."
	keywords: "button, menu, option, drop down, popup"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_OPTION_BUTTON

inherit
	EV_BUTTON
		rename
--			add_click_command as add_popup_command
		export {NONE}
			align_text_center,
			align_text_left,
			align_text_right,
			set_text
		redefine
			implementation,
			create_implementation
--			make
		end

	EV_MENU_HOLDER
		redefine
			implementation
		end

create
	default_create,
	make_with_text

feature -- Access

	menu: EV_MENU is
			-- Displayed when clicked.
		do
			Result := implementation.menu
		ensure
			bridge_ok: Result = implementation.menu
		end

feature -- Status setting 

	clear_selection is
			-- Clear the selection by putting the `text'
			-- of the menu on the option button if there is one,
			-- otherwise the first menu item.
		do
			implementation.clear_selection
		end

feature -- Status report

	selected_item: EV_MENU_ITEM is
			-- which menu item is selected.
			-- Void if the selection is the 'text' of the menu.
		do
			Result := implementation.selected_item
		end

feature {NONE} -- Implementation

	implementation: EV_OPTION_BUTTON_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

	create_implementation is
			-- Create implementation of option button.
		do
			create {EV_OPTION_BUTTON_IMP} implementation.make (Current)
		end

end -- class EV_OPTION_BUTTON

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
--| Revision 1.12  2000/02/14 11:40:52  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.11.6.6  2000/02/02 00:05:40  oconnor
--| modifed for new menu classes
--|
--| Revision 1.11.6.5  2000/01/28 22:24:25  oconnor
--| released
--|
--| Revision 1.11.6.4  2000/01/27 19:30:56  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.11.6.3  2000/01/17 20:06:31  rogers
--| Renamed
--| 	set_center_alignment -> align_text_center
--| 	set_let_alignment -> align_text_left
--| 	set_right_alignment -> align_text_right
--|
--| Revision 1.11.6.2  1999/12/17 19:26:27  rogers
--| Child menu has been simplified considerably.
--|
--| Revision 1.11.6.1  1999/11/24 17:30:54  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.11.2.3  1999/11/18 03:41:50  oconnor
--| rewrote press command handling to use action sequence
--|
--| Revision 1.11.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
