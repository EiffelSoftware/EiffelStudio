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
			make_with_text,
			parent_imp
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization
	
	make_with_text (txt: STRING) is
			-- Create menu item
		do
			widget := gtk_check_menu_item_new
			gtk_check_menu_item_set_show_toggle (widget, True)
			initialize
			create_text_label (txt)
			gtk_misc_set_alignment (label_widget, 0.0, 0.5)
			gtk_misc_set_padding (label_widget, 21, 0)
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
	
feature -- Status setting

	set_state (flag: BOOLEAN) is
			-- Make `flag' the new state of the menu-item.
		do
			gtk_check_menu_item_set_active (widget, flag)
		end

feature -- Event : command association

	add_deactivate_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Make `cmd' the executed command when the item is
			-- unactivated.
		do
			add_command (widget, "deselect", cmd, arg)
		end	

feature -- Event -- removing command association

	remove_deactivate_commands is
			-- Empty the list of commands to be executed when
			-- the item is deactivated.
		do	
			remove_commands (widget, deselect_id)
		end

end -- class EV_CHECK_MENU_ITEM_IMP

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
