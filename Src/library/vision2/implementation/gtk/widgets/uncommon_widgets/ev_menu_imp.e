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
		
	EV_MENU_ITEM_HOLDER_IMP
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

			-- Create the array where the items will be listed.
			!! ev_children.make (1)
		end
	
        make_with_text (txt: STRING) is
                        -- Create a menu with name. 
		do
			-- Create the gtk menu.
			name := txt
			widget := gtk_menu_new ()

			gtk_object_ref (widget)

			-- Create the array where the items will be listed.
			!! ev_children.make (1)
		end	

feature -- Access

	parent_imp: EV_MENU_HOLDER_IMP
		-- Parent of the current menu.

	count: INTEGER is
			-- Number of items in the menu.
		do
			Result := ev_children.count
		end

	get_item (index: INTEGER): EV_MENU_ITEM is
			-- Give the item of the list at the zero-base
			-- `index'.
		do
			Result ?= (ev_children.i_th (index)).interface
		end

feature -- Status report

	text: STRING is
			-- Label of the current menu
		do
			Result := name
		end

feature -- Element change

	set_parent (par: EV_MENU_HOLDER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		local
			par_imp: EV_MENU_HOLDER_IMP
		do
			if parent_imp /= Void then
				gtk_object_ref (widget)
				parent_imp.remove_menu (Current)
				parent_imp := Void
			end
			if par /= Void then
				par_imp ?= par.implementation
				check
					parent_not_void: par_imp /= Void
				end
				parent_imp ?= par_imp
				par_imp.add_menu (Current)
				show
				gtk_object_unref (widget)
			end
		end

feature {EV_MENU_HOLDER_IMP} -- Implementation

	name: STRING

feature {NONE} -- Implementation - Assertion	

	parent_is_option_button: BOOLEAN is
			-- Is the parent an option button?
			-- We need this because it requires a special
			-- processing when the parent is an option button.
		local
			par: EV_OPTION_BUTTON
		do
			par ?= parent_imp.interface
			Result := (par /= Void)
		end	

feature {NONE} -- Implementation

	add_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Add menu item into container
		local
			option_button_par: EV_OPTION_BUTTON_IMP
		do
			-- If the parent is an option button:
			if ((parent_imp /= Void) and then (parent_is_option_button)) then

--				-- 1) We need to update the parent (the option button)
--				-- `menu_items_array' by adding the new menu_item:
--				option_button_par ?= parent_imp
--				option_button_par.menu_items_array.force (item_imp)

				-- 2) We do the following to resize the option button when adding
				-- new menu items with a longer length: 

				-- adding a reference to the menu before removing it from its parent:
				gtk_object_ref (widget)
				-- removing the menu from its parent, the option button:
				gtk_option_menu_remove_menu (parent_imp.widget)
				-- adding the item_imp to the menu:
				gtk_menu_append (widget, item_imp.widget)
				-- re-adding the menu to the option button:
				gtk_option_menu_set_menu (parent_imp.widget, widget)
				-- setting the number of reference of the menu to 1:
				gtk_object_unref (widget)

			-- If the parent is not an option button:
			else
				gtk_menu_append (widget, item_imp.widget)
			end

			-- Update the array `ev_children'.
			ev_children.extend (item_imp)			
		end

	remove_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Remove the item from the container.
		local
			option_button_par: EV_OPTION_BUTTON_IMP
		do
			gtk_container_remove (GTK_CONTAINER (widget), item_imp.widget)

--			-- If the parent is an option button,
--			-- we also remove the item from its array of
--			-- items, `menu_items_array'.
--			if parent_is_option_button then
--				option_button_par ?= parent_imp
--				option_button_par.menu_items_array.search (item_imp)
--				option_button_par.menu_items_array.remove
--			end

			-- Update the array `ev_children'.
			ev_children.prune_all (item_imp)
		end
	
feature {EV_MENU_ITEM_IMP, EV_OPTION_BUTTON_IMP} -- Implementation

--	ev_children: ARRAYED_LIST [EV_MENU_ITEM_IMP]
--			-- List of the children

--	clear_ev_children is
--			-- Clear all the items of the list.
--		local
--			list: ARRAYED_LIST [EV_MENU_ITEM_IMP]
--		do
--			from
--				list := ev_children
--				list.start
--			until
--				list.after
--			loop
--				list.item.interface.remove_implementation
--				list.forth
--			end
--			list.wipe_out
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
