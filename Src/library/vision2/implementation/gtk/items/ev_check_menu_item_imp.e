indexing

	description:
		"EiffelVision check menu item. gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$";
	revision: "$Revision$"

class EV_CHECK_MENU_ITEM_IMP

inherit
	EV_CHECK_MENU_ITEM_I
		redefine
			parent_imp
		end

	EV_MENU_ITEM_IMP
		redefine
			make,
			parent_imp,
			set_selected,
			is_selected
		end

create
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Create an item with an empty name.
		do
			-- Create the gtk object.
			widget := gtk_check_menu_item_new
			gtk_object_ref (widget)
			gtk_check_menu_item_set_show_toggle (widget, True)

			-- Create the `box'.
			initialize

			-- The interface does not call `widget_make' so we need 
			-- to connect `destroy_signal_callback'
			-- to `destroy' event.
			initialize_object_handling
		end

feature -- Access

	parent_imp: EV_MENU_ITEM_HOLDER_IMP
			-- Parent of the item.

feature -- Status report
	
	state: BOOLEAN is
			-- Is current menu-item checked ?.
		do
			Result := c_gtk_check_menu_item_active (widget)
		end 
	
	is_selected: BOOLEAN is
			-- Is current menu-item checked ?.
		do
			Result := c_gtk_check_menu_item_active (widget)
		end 
	
feature -- Status setting

	set_state (flag: BOOLEAN) is
			-- Make `flag' the new state of the menu-item.
		do
			gtk_check_menu_item_set_active (widget, flag)
		end

	set_selected (flag: BOOLEAN) is
			-- Make `flag' the new state of the menu-item.
		do
			gtk_check_menu_item_set_active (widget, flag)
		end

feature -- Event : command association

--	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Make `cmd' the executed command when the item is
			-- unactivated.
		do
			add_command (widget, "deselect", cmd, arg, default_pointer)
		end	

feature -- Event -- removing command association

--	remove_deactivate_commands is
	remove_unselect_commands is
			-- Empty the list of commands to be executed when
			-- the item is deactivated.
		do	
			remove_commands (widget, deselect_id)
		end

end -- class EV_CHECK_MENU_ITEM_IMP

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
