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

create
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Create a menu
		do
			widget := gtk_menu_new ()
			gtk_object_ref (widget)

			-- Create the array where the items will be listed.
			create ev_children.make (1)
		end
	
        make_with_text (txt: STRING) is
                        -- Create a menu with name. 
		do
			-- Create the gtk menu.
			name := txt
			widget := gtk_menu_new ()

			gtk_object_ref (widget)

			-- Create the array where the items will be listed.
			create ev_children.make (1)
		end	

feature -- Access

	parent_imp: EV_MENU_HOLDER_IMP
		-- Parent of the current menu.

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

	set_text (txt: STRING) is
			-- Assign `txt' to `text'.
		local
			option_button_imp: EV_OPTION_BUTTON_IMP
			a: ANY
		do
			name := txt

			-- If the parent is an option button, we add an GtkMenuItem
			-- for a title with `txt' as the value.
			if ((parent_imp /= Void) and then (parent_is_option_button)) then
				option_button_imp ?= parent_imp
				a := txt.to_c
				option_button_imp.set_menu_title_widget (gtk_menu_item_new_with_label ($a))
				gtk_widget_show (option_button_imp.menu_title_widget)
				-- Append it so it is the first item.
				gtk_menu_prepend (widget, option_button_imp.menu_title_widget)
			end	
		end	

	clear_items is
			-- Clear all the items of the list.
			-- (Remove them from the menu and destroy them).
		do
			-- clear the EiffelVision objects.
			clear_ev_children

			-- clear the gtk objects.
			c_gtk_menu_remove_all_items (widget)
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

				-- 1) We do the following to resize the option button when adding
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

				-- 2) Foreground and background Colors.
				-- Set the menu colors to the same ones as the option button's.
				option_button_par ?= parent_imp
				c_gtk_widget_set_fg_color (item_imp.widget, option_button_par.foreground_color.red,
					option_button_par.foreground_color.green, option_button_par.foreground_color.blue)
				c_gtk_widget_set_bg_color (item_imp.widget, option_button_par.background_color.red,
					option_button_par.background_color.green, option_button_par.background_color.blue)

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
			default_colors: EV_DEFAULT_COLORS
				-- Needed to reset the menu item's colors to
				-- the default colors.
		do
			gtk_container_remove (GTK_CONTAINER (widget), item_imp.widget)

			-- Update the array `ev_children'.
			ev_children.prune_all (item_imp)

			-- Set the menu colors to the default colors. We set it to those colors
			-- because for now, the user can not set colors on EV_MENU.
			c_gtk_widget_set_fg_color (item_imp.widget, default_colors.default_foreground_color.red,
				default_colors.default_foreground_color.green, default_colors.default_foreground_color.blue)
			c_gtk_widget_set_bg_color (item_imp.widget, default_colors.default_background_color.red,
				default_colors.default_background_color.green, default_colors.default_background_color.blue)
		end
	
end -- class EV_MENU_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
