indexing
	description: "EiffelVision item, gtk implementation";
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	EV_ITEM_IMP

inherit
	EV_ITEM_I

	EV_TEXTABLE_IMP

	EV_PIXMAPABLE_IMP
		rename
			set_parent as widget_set_parent,
			parent_imp as widget_parent_imp,
			parent_set as widget_parent_set,
			add_double_click_command as old_add_dblclk,
			remove_double_click_commands as old_remove_dblclk
		redefine
			has_parent
		end
		
	EV_WIDGET_IMP
			-- Inheriting from widget,
			-- because items are widget in gtk
		rename
			set_parent as widget_set_parent,
			parent_imp as widget_parent_imp,
			parent_set as widget_parent_set,
			add_double_click_command as old_add_dblclk,
			remove_double_click_commands as old_remove_dblclk
		redefine
			has_parent
		end

	EV_GTK_ITEMS_EXTERNALS

feature -- Acces

	parent_widget: EV_WIDGET is
			-- Parent widget of the current item
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Assertion features

	has_parent: BOOLEAN is
			-- True if the widget has a parent, False otherwise
		do
			Result := parent_imp /= void
		end

feature -- Event : command association

	add_activate_command (command: EV_COMMAND; arguments: EV_ARGUMENT) is
			-- Add 'command' to the list of commands to be
			-- executed when the menu item is activated
			-- The toggle event doesn't work on gtk, then
			-- we add both event command.
		do
			add_command ("select", command, arguments)
		end

	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Make `cmd' the executed command when the item is
			-- unactivated.
		do
			add_command ("deselect", cmd, arg)
		end	

feature -- Event -- removing command association

	remove_activate_commands is
			-- Empty the list of commands to be executed when
			-- the item is activated.
		do
			check False end		
		end	

	remove_deactivate_commands is
			-- Empty the list of commands to be executed when
			-- the item is deactivated.
		do	
			check False end
		end

end -- class EV_ITEM_IMP

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

