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

	make (par: EV_MENU_CONTAINER) is
			-- Create a menu
		do
--			make_with_text (par, "")
			widget := gtk_menu_new ()
		end
	
        make_with_text (par: EV_MENU_CONTAINER; txt: STRING) is
                        -- Create a menu with name. 
		local
			a: ANY
			menu: POINTER
		do
--			a := txt.to_c
--			widget := gtk_menu_item_new_with_label ($a)
--			menu := gtk_menu_new ()
--			gtk_menu_item_set_submenu (GTK_MENU_ITEM (widget), menu)

			name := txt
			widget := gtk_menu_new ()
		end	

feature -- Status report

	text: STRING is
			-- Label of the current menu
		do
			Result := name
		end

feature {EV_MENU_CONTAINER_IMP} -- Implementation

	name: STRING

feature {NONE} -- Implementation	

	add_item (child: EV_MENU_ITEM) is
			-- Add menu item into container
		local
			item_imp: EV_MENU_ITEM_IMP
		do
			item_imp ?= child.implementation
			check
				correct_imp: item_imp /= Void
			end
			gtk_menu_append (widget, item_imp.widget)
		end

--	add_menu_item_pointer (item_p: POINTER) is
--		do
--			gtk_menu_append (gtk_menu (widget), item_p)
--		end
	
--	widget_make (par: EV_CONTAINER) is
--			-- Cannot be called
--		do
--			check
--				do_not_call: False
--			end
--		end


end -- class EV_MENU_IMP

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
