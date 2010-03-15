note
	description: 
		"Button that displays a `menu' when pressed.%N%
		%The most recently `selected_item' is displayed on the button."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "button, menu, option, drop down, popup"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_OPTION_BUTTON
	
obsolete "Very limited. Just call show on an EV_MENU when an EV_BUTTON is selected and add custom behaviour."

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

	initialize
			-- Create `menu' and connect event handlers.
		do
			Precursor {EV_BUTTON}
			create menu
			select_actions.extend (agent menu.show)
			menu.item_select_actions.extend (agent on_item_select)
		end

feature -- Access

	menu: EV_MENU
			-- Displayed when pressed.

feature -- Status setting

	set_selected_item (an_item: EV_MENU_ITEM)
		require
			not_destroyed: not is_destroyed
			menu_has_item: menu.has (an_item)
		do
			on_item_select (an_item)
		ensure
			selected: selected_item = an_item
		end

	remove_selection
			-- Make `selected_item' `Void'.
			-- Assign `menu' text to `text' if available,
			-- otherwise assign `menu'.first.text to `text'.
		require
			not_destroyed: not is_destroyed
		do
			if not menu.text.is_empty then
				implementation.set_text (menu.text)
			elseif menu.first /= Void and then not menu.first.text.is_empty then
				implementation.set_text (menu.first.text)
			else
				remove_text
			end
			selected_item := Void
		ensure
			selected_item_void: selected_item = Void
			menu_text_used_first:
				not menu.text.is_empty implies text.is_equal (menu.text)
			menu_first_text_used_otherwise:
				menu.text = Void and menu.first /= Void and not menu.first.text.is_empty
				implies text.is_equal (menu.first.text)
		end

feature -- Status report

	selected_item: EV_MENU_ITEM
			-- Most recently selected `menu' item.

feature -- Element change

	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to `text' and to `menu'.text.
		do
			implementation.set_text (a_text)
			menu.set_text (a_text)
		end
  
feature {NONE} -- Implementation

	on_item_select (an_item: EV_MENU_ITEM)
			-- Update `selected_item'
			-- Update `text'
		require
			an_item_not_void: an_item /= Void
		do
			selected_item := an_item
			implementation.set_text (an_item.text)
		ensure	
			selected_item_assigned: selected_item = an_item
			text_assigned: an_item.text = Void and text = Void
				or text.is_equal (an_item.text)
		end

invariant
	menu_not_void: is_usable implies menu /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_OPTION_BUTTON

