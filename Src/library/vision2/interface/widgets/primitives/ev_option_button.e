indexing
	description: 
		"Button that displays a `menu' when pressed.%N%
		%The most recently `selected_item' is displayed on the button."
	keywords: "button, menu, option, drop down, popup"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_OPTION_BUTTON

inherit
	EV_BUTTON
		redefine
			initialiaze,
			set_text
		end

create
	default_create,
	make_with_text,
	make_for_test

feature {EV_ANY} -- Initialization

	initialize is
			-- Create `menu' and connect event handlers.
		do
			{EV_BUTTON} Precursor
			create menu
			press_actions.extend (menu~show)
--|FIXME add item_select_actions to EV_MENU
--|			menu.item_select_actions.extend (~on_item_select)
		end

feature -- Access

	menu: EV_MENU
			-- Displayed when pressed.

feature -- Status setting 

	clear_selection is
			-- Make `selected_item' `Void'.
			-- Assign `menu'.text to `text' if avalible,
			-- otherwise assign `menu'.first.text to `text'.
		do
			if menu.text /= Void then
				implementation.set_text (menu.text)
			elseif menu.first /= Void and then menu.first.text /= Void then
				implementation.set_text (menu.first.text)
			else
				remove_text
			end
			selected_item := Void
		ensure
			selected_item_void: selected_item = Void
			menu_text_used_first:
				menu.text /= Void implies text.is_equal (menu.text)
			menu_first_text_used_otherwise:
				menu.first /= Void and menu.first.text /= Void
				implies text.is_equal (menu.first.text)
		end

feature -- Status report

	selected_item: EV_MENU_ITEM
			-- Most recently selected `menu' item.

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text' and to `menu'.text.
		do
			implementation.set_text (a_text)
			menu.set_text (a_text)
		end
  
feature {NONE} -- Implmentation

	on_item_select (an_item: EV_MENU_ITEM) is
			-- Update `selected_item'
			-- Update `text'
		require
			an_item_not_viod: an_item /= Void
		do
			selected_item := an_item
			if an_item.text = Void then
				remove_text
			else
				implementation.set_text (an_item.text)
			end
		ensure	
			selected_item_assigned: selected_item = an_item
			text_assigned: an_item.text = Void and text = Void
				or text.is_equal (an_item.text)
		end

invariant
	menu_not_void: is_useable implies menu /= Void

end -- class EV_OPTION_BUTTON

--!-----------------------------------------------------------------------------
--! EiffelVision : library of reusable components for ISE Eiffel.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.17  2000/03/20 20:05:22  oconnor
--| proposed new platform independant implementation.
--|
--| Revision 1.16  2000/03/01 03:28:43  oconnor
--| added make_for_test
--|
--| Revision 1.15  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.14  2000/02/19 03:10:15  oconnor
--| undefine action seq create from menu item list
--|
--| Revision 1.13  2000/02/19 01:08:26  oconnor
--| removed refs to old EV_MENU_HOLDER class
--|
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
