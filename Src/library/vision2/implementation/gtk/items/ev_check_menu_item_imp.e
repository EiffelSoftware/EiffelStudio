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
			interface,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		end

	EV_MENU_ITEM_IMP
		redefine
			make,
			interface,
			on_activate,
			menu_item_type,
			pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a menu.
		do
			base_make (an_interface)
			set_c_object (C.gtk_check_menu_item_new)
			C.gtk_check_menu_item_set_show_toggle (c_object, True)
			disable_select
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is this menu item checked?
		do
			Result := C.gtk_check_menu_item_struct_active (c_object).to_boolean
		end

feature -- Status setting

	enable_select is
			-- Select this menu item.
		do
			if not is_selected then
				ignore_select_actions := True
				C.gtk_check_menu_item_set_active (c_object, True)		
				ignore_select_actions := False
			end
		end

	disable_select is
			-- Deselect this menu item.
		do
			if is_selected then
				ignore_select_actions := True
				C.gtk_check_menu_item_set_active (c_object, False)
				ignore_select_actions := False
			end	
		end

	toggle is
			-- Invert the value of `is_selected'.
		do
			if is_selected then
				disable_select
			else
				enable_select
			end
		end
		
feature {EV_MENU_ITEM_LIST_IMP} -- Implementation

	menu_item_type: INTEGER is
		do
			Result := Check_type
		end

feature {NONE} -- Implementation

	on_activate is
			-- `Current' has been activated.
		do
			if not ignore_select_actions then
				{EV_MENU_ITEM_IMP} Precursor
			end
		end
		
	ignore_select_actions: BOOLEAN
			-- Should select actions be ignore, ues if enable_select is called.
			
			
feature {EV_ANY_I} -- Implementation

	pointer_motion_actions_internal: EV_POINTER_MOTION_ACTION_SEQUENCE

	pointer_button_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

	pointer_double_press_actions_internal: EV_POINTER_BUTTON_ACTION_SEQUENCE

feature {NONE} -- Implementation

	interface: EV_CHECK_MENU_ITEM

end -- class EV_CHECK_MENU_ITEM_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

