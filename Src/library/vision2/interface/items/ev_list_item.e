indexing	
	description: 
		"EiffelVision list item. This items are used in %
		%the lists."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class 

	EV_LIST_ITEM

inherit
	EV_ITEM
		redefine
			implementation
		end

	EV_PIXMAP_CONTAINER
		redefine
			implementation
		end
	
creation
	
	make_with_text, make
	
feature {NONE} -- Initialization
	
	make (par: EV_LIST) is
			-- Create a list item with no label and add it
			-- to `par' list.
		do
			!EV_LIST_ITEM_IMP!implementation.make (par)
			implementation.set_interface (Current)
			par.implementation.add_item (Current)
		end

	make_with_text (par: EV_LIST; txt: STRING) is
			-- Create a list item with `txt' for  label and
			-- add it in the `par' list.
		do
			!EV_LIST_ITEM_IMP!implementation.make_with_text (par, txt)
			implementation.set_interface (Current)
			par.implementation.add_item (Current)
		end	

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected
		require
			exists: not destroyed
		do
			Result := implementation.is_selected
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		require
			exists: not destroyed
		do
			implementation.set_selected (flag)
		end

	toggle is
			-- Change the state of selection of the item.
		require
			exists: not destroyed
		do
			implementation.toggle
		end

feature -- Event : command association

	add_double_click_command (a_command: EV_COMMAND; 
			       arg: EV_ARGUMENTS) is
			-- Add 'command' to the list of commands to be
			-- executed when the item is double clicked
		require
			exists: not destroyed
		do
			implementation.add_double_click_command (a_command, arg)
		end	

feature -- Implementation

	implementation: EV_LIST_ITEM_I

end -- class EV_LIST_ITEM

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
--|----------------------------------------------------------------
