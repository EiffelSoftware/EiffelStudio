indexing
	description: 
		"EiffelVision option button is a button that%
		% displays a popup_menu when we click on it."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_OPTION_BUTTON

inherit
	EV_MENU_HOLDER
		redefine
			implementation
		end

	EV_BUTTON
		rename
			add_click_command as add_popup_command
		export {NONE}
			set_center_alignment,
			set_left_alignment,
			set_right_alignment,
			set_text
		redefine
			implementation,
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is         
			-- Create a menu widget with `par' as parent.
			-- We can't use `widget_make' here, because a menu
			-- is not a child, otherwise, you couldn't put more
			-- than a menu in a window. A menu is an option of a
			-- window
		do
			!EV_OPTION_BUTTON_IMP!implementation.make
			managed := par.manager
			widget_make (par)
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

end -- class EV_OPTION_BUTTON

--|----------------------------------------------------------------
--| EiffelVision : library of reusable components for ISE Eiffel.
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
--|---------------------------------------------------------------

