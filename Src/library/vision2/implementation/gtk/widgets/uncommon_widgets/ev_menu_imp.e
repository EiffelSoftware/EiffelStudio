indexing

	description: 
		"EiffelVision menu box, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	
	EV_MENU_IMP
	
inherit
	
	EV_MENU_I
		
	EV_MENU_ITEM_CONTAINER_IMP
		rename
			make as widget_make
		end

creation
	
	make_with_text

feature {NONE} -- Initialization

	make (par: EV_MENU_ITEM_CONTAINER) is
			-- Create a menu
		do
			widget := gtk_menu_new ()
		end
	
        make_with_text (par: EV_MENU_ITEM_CONTAINER; txt: STRING) is
                        -- Create a menu with name. 
		do
			name := txt
			make (par)
		end	
	

feature {NONE} -- Implementation	

	add_menu_item_pointer (item_p: POINTER) is
		do
			gtk_menu_append (gtk_menu (widget), item_p)
		end
	
feature {EV_MENU_ITEM_CONTAINER_IMP} -- Implementation

	name: STRING

	widget_make (par: EV_CONTAINER) is
			-- Cannot be called
		do
			check
				do_not_call: False
			end
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
