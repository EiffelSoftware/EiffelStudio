indexing	
	description: 
		"EiffelVision menu item. Menu a container of menu itemsInvisible container that allows unlimited number of other widgets to be packed inside it. Box controls the location the children's location and size automatically."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class EV_MENU_ITEM

inherit

	EV_TEXT_CONTAINER
		rename
			make_with_text as widget_make_with_text
		redefine
			implementation
		end
	
creation
	
	make_with_text
	
feature {NONE} -- Initialization
	
	make_with_text (par: EV_MENU_ITEM_CONTAINER; txt: STRING) is
			-- Create menu item
		do
			!EV_MENU_ITEM_IMP!implementation.make_with_text (par, txt)
			par.add_menu_item (Current)
		end	
	
feature -- Event - command association
	
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

feature -- Implementation

	widget_make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Do nothing here, but need to be implemented.
		do
		end

	destroyed: BOOLEAN is
		do
			Result := implementation.destroyed
		end

feature -- Implementation
	
	implementation: EV_MENU_ITEM_I

end -- class EV_MENU

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
