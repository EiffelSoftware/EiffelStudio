indexing

	description: 
		"EiffelVision menu. Menu contains several menu items and shows them when the menu is opened."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU

inherit
	EV_MENU_ITEM_HOLDER 
		redefine
			implementation
		end

create
	make,
	make_with_text
	
feature {NONE} -- Initialization

	make (par: EV_MENU_HOLDER) is
			-- Create an empty menu.
		do
			!EV_MENU_IMP!implementation.make
			implementation.set_interface (Current)
			implementation.set_parent (par)
		end

	make_with_text (par: EV_MENU_HOLDER; label: STRING) is         
			-- Create a menu widget with `par' as
			-- parent
		do
			!EV_MENU_IMP!implementation.make_with_text (label)
			implementation.set_interface (Current)
			implementation.set_parent (par)
		end	

feature -- Access

	text: STRING is
			-- Label of the current menu
		require
			exists: not destroyed
		do
			Result := implementation.text
		end

feature -- Element change

	set_parent (par: EV_MENU_HOLDER) is
			-- Make `par' the new parent of the item.
		require
			exists: not destroyed
		do
			implementation.set_parent (par)
		end

	set_text (txt: STRING) is
			-- Assign `txt' to `text'.
		require
			exists: not destroyed
			valid_text: txt /= Void
		do
			implementation.set_text (txt)
		ensure
			text_set: text.is_equal (txt)
		end

feature -- Implementation
	
	implementation: EV_MENU_I	
			-- Platform dependent access.

end -- class EV_MENU

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
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
--!----------------------------------------------------------------
