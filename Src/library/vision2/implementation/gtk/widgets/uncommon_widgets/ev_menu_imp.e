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
		redefine
			parent_imp
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Create a menu
		do
			widget := gtk_menu_new ()
			gtk_object_ref (widget)
		end
	
        make_with_text (txt: STRING) is
                        -- Create a menu with name. 
		do
			name := txt
			widget := gtk_menu_new ()
			gtk_object_ref (widget)
		end	

feature -- Access

	parent_imp: EV_MENU_CONTAINER_IMP
		-- Parent of the current menu.

feature -- Status report

	text: STRING is
			-- Label of the current menu
		do
			Result := name
		end

feature -- Element change

	set_parent (par: EV_MENU_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		local
			par_imp: EV_MENU_CONTAINER_IMP
		do
			if parent_imp /= Void then
				gtk_object_ref (widget)
				parent_imp.remove_menu (Current)
				parent_imp := Void
			end
			if par /= Void then
				show
				par_imp ?= par.implementation
				check
					parent_not_void: par_imp /= Void
				end
				parent_imp ?= par_imp
				par_imp.add_menu (Current)
				gtk_object_unref (widget)
			end
		end

feature {EV_MENU_CONTAINER_IMP} -- Implementation

	name: STRING

feature {NONE} -- Implementation	

	add_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Add menu item into container
		do
			gtk_menu_append (widget, item_imp.widget)
		end

	remove_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Remove the item from the container.
		do
			gtk_container_remove (GTK_CONTAINER (widget), item_imp.widget)
		end
	
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
