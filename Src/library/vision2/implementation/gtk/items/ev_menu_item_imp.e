indexing

	description: 
		"EiffelVision menu item, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	
	EV_MENU_ITEM_IMP
	
inherit
	
	EV_MENU_ITEM_I

	EV_PRIMITIVE_IMP
		
	EV_TEXT_CONTAINER_IMP

creation
	
	make, make_with_text

feature {NONE} -- Initialization
	
	
	make_with_text (par: EV_MENU_ITEM_CONTAINER; txt: STRING) is
			-- Create menu item
		local
                        a: ANY
		do
			a ?= txt.to_c
			widget := gtk_menu_item_new_with_label ($A)
			show -- Have to show the menu item, otherwise it is not visible
		end		
	
feature {NONE} -- Implementation
	
        label_widget: POINTER is
                        -- gtk widget of the label inside the button
                do
                        Result := c_gtk_get_label_widget (widget)
		end
	
feature -- Element change
	
	set_menu (menu_imp: EV_MENU_IMP) is
			-- Set menu for menu item
		do
			gtk_menu_item_set_submenu ( gtk_menu_item (widget), 
						    menu_imp.widget )
		end

feature -- Event - command association
	
	add_activate_command ( command: EV_COMMAND; 
			       arguments: EV_ARGUMENTS) is
			-- Add 'activat' signal for menu item
		do
			add_command ( "activate", command,  arguments )
		end
end

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
