indexing	
	description: 
		"EiffelVision item. Top class of menu_item, list_item   %
		% and tree_item. This item isn't a widget, because most %
		% of the features of the widgets are inapplicable  here."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_ITEM

inherit
	EV_ANY
		redefine
			implementation
		end

	EV_TEXT_CONTAINER
		rename
			make as wrong_make,
			make_with_text as wrong_make_with_text
		redefine
			implementation
		end

feature -- Status settings

-- XX to implement
--	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void.
--		require
--			exists: not destroyed
--		do
--			implementation.set_parent (par)
--		ensure
--			parent_set: parent = par
--		end

feature -- Event : command association

	add_activate_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Make `cmd' the executed command when the item is 
			-- activated.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_activate_command (cmd, arg)
		end	

	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Make `cmd' the executed command when the item is
			-- unactivated.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_deactivate_command (cmd, arg)		
		end

feature {NONE} -- Inapplicable

	wrong_make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Do nothing here because the parent isn't 
			-- a container but need to be implemented.
		do
		end

feature -- Implementation

	implementation: EV_ITEM_I

end -- class EV_ITEM

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
--|----------------------------------------------------------------
