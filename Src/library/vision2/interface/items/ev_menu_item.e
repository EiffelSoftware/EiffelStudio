indexing	
	description: 
		"EiffelVision menu item. Menu a container of menu itemsInvisible container that allows unlimited number of other widgets to be packed inside it. Box controls the location the children's location and size automatically."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class EV_MENU_ITEM

inherit

	EV_PRIMITIVE 
		redefine
			implementation
		end
	
	EV_TEXT_CONTAINER
		redefine
			implementation, make
		end

	
creation
	
	make, make_with_text
	
feature {NONE} -- Initialization
	
	make (par: EV_MENU_ITEM_CONTAINER) is
		do
			Precursor (par)
		end
		
	make_with_text (par: EV_MENU_ITEM_CONTAINER; txt: STRING) is
			-- Create menu item
		do
			!EV_MENU_ITEM_IMP!implementation.make_with_text (par, txt)
			widget_make (par)
		end	
	
feature -- Element change
	
	set_menu (menu: EV_MENU) is
			-- Set menu for menu item
		require
			valid_menu: menu /= Void
		do
			implementation.set_menu (menu.implementation)
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

feature {EV_MENU_ITEM_CONTAINER} -- Implementation
	
	implementation: EV_MENU_ITEM_I	

end -- class EV_MENU

