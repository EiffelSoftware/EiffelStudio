indexing
	description: "Eiffel Vision radio menu item. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

class
	EV_RADIO_MENU_ITEM_IMP

inherit
	EV_RADIO_MENU_ITEM_I
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			on_activate,
			interface,
			make,
			menu_item_type
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a menu item.
		do
			base_make (an_interface)
			set_c_object (C.gtk_radio_menu_item_new (NULL))
			C.gtk_check_menu_item_set_show_toggle (c_object, True)
			C.gtk_check_menu_item_set_active (c_object, True)
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
			C.gtk_check_menu_item_set_active (c_object, True)
		end
		
feature {EV_MENU_ITEM_LIST_IMP} -- Implementation

	menu_item_type: INTEGER is
		do
			Result := Radio_type
		end

feature {EV_ANY_I} -- Implementation

	on_activate is
		do
			if is_selected then
				Precursor
			end
		end

	set_radio_group (a_gslist: POINTER) is
			-- Make current a member of `a_gslist' radio group.
		do
			C.gtk_radio_menu_item_set_group (c_object, a_gslist)
		end

	radio_group: POINTER is
		do
			Result := C.gtk_radio_menu_item_group (c_object)
		end

	interface: EV_RADIO_MENU_ITEM

end -- class EV_RADIO_MENU_ITEM_IMP

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

