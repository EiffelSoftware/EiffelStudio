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
			initialize,
			set_text
		end

create
	default_create,
	make_with_text

feature {NONE} -- Initialization

	initialize is
			-- Create `menu' and connect event handlers.
		do
			Precursor {EV_BUTTON}
			create menu
			select_actions.extend (menu~show)
			menu.item_select_actions.extend (~on_item_select)
		end

feature -- Access

	menu: EV_MENU
			-- Displayed when pressed.

feature -- Status setting

	set_selected_item (an_item: EV_MENU_ITEM) is
		require
			not_destroyed: not is_destroyed
			menu_has_item: menu.has (an_item)
		do
			on_item_select (an_item)
		ensure
			selected: selected_item = an_item
		end

	remove_selection is
			-- Make `selected_item' `Void'.
			-- Assign `menu'.text to `text' if avalible,
			-- otherwise assign `menu'.first.text to `text'.
		require
			not_destroyed: not is_destroyed
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
				menu.text = Void and menu.first /= Void and menu.first.text /= Void
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
  
feature {NONE} -- Implementation

	on_item_select (an_item: EV_MENU_ITEM) is
			-- Update `selected_item'
			-- Update `text'
		require
			an_item_not_void: an_item /= Void
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
	menu_not_void: is_usable implies menu /= Void

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
