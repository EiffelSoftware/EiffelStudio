indexing
	description: "EiffelVision check menu. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

class
	EV_CHECK_MENU_ITEM_IMP

inherit
	EV_CHECK_MENU_ITEM_I
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			make,
			interface,
			on_activate
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a menu.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_check_menu_item_new)
			{EV_GTK_EXTERNALS}.gtk_check_menu_item_set_show_toggle (c_object, True)
			disable_select
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is this menu item checked?
		do
			Result := {EV_GTK_EXTERNALS}.gtk_check_menu_item_struct_active (c_object).to_boolean
		end

feature -- Status setting

	enable_select is
			-- Select this menu item.
		do
			if not is_selected then
				ignore_select_actions := True
				{EV_GTK_EXTERNALS}.gtk_check_menu_item_set_active (c_object, True)		
				ignore_select_actions := False
			end
		end

	disable_select is
			-- Deselect this menu item.
		do
			if is_selected then
				ignore_select_actions := True
				{EV_GTK_EXTERNALS}.gtk_check_menu_item_set_active (c_object, False)
				ignore_select_actions := False
			end	
		end

feature {NONE} -- Implementation

	on_activate is
			-- `Current' has been activated.
		do
			if not ignore_select_actions then
				Precursor {EV_MENU_ITEM_IMP}
			end
		end
		
	ignore_select_actions: BOOLEAN
			-- Should select actions be ignore, ues if enable_select is called.

feature {NONE} -- Implementation

	interface: EV_CHECK_MENU_ITEM

end -- class EV_CHECK_MENU_ITEM_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

