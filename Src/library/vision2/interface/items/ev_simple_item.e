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

	EV_TEXT_CONTAINER
		rename
			make as wrong_make,
			make_with_text as wrong_make_with_text
		redefine
			implementation
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is current object destroyed
		do
			Result := implementation.destroyed
		end

feature -- Status setting

	destroy is
			-- Destroy the current item
		do
			implementation.destroy
		ensure
			destroyed: destroyed
		end

feature -- Event : command association

	add_activate_command ( command: EV_COMMAND; 
			       arguments: EV_ARGUMENTS) is
			-- Add 'command' to the list of commands to be
			-- executed when the menu item is activated
		require
			valid_command: command /= Void
		do
			implementation.add_activate_command ( command, 
							      arguments )
		end	

feature {NONE} -- Inapplicable

	wrong_make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Do nothing here because the parent isn't 
			-- a container but need to be implemented.
		do
		end

feature -- Implementation

	implementation: EV_ITEM_I

	remove_implementation is
			-- Remove implementation of Current widget.
		do
			implementation := Void
		ensure
			void_implementation: implementation = Void
		end

end -- class EV_ITEM

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
