indexing
	description:
		"Eiffel Vision menu separator. Mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_SEPARATOR_IMP

inherit
	EV_MENU_SEPARATOR_I
		undefine
			parent
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			make,
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with `an_interface'.
		do
			base_make (an_interface)
			make_id
		end

feature {EV_MENU_ITEM_LIST_IMP} -- Access

	radio_group: LINKED_LIST [EV_RADIO_MENU_ITEM_IMP]
			-- Radio items following this separator.

	create_radio_group is
			-- Create `radio_group'.
		require
			radio_group_void: radio_group = Void
		do
			create radio_group.make
		ensure
			radio_group_not_void: radio_group /= Void
		end

	set_radio_group (a_list: like radio_group) is
			-- Assign `a_list' to `radio_group'.
		require
			a_list_not_void: a_list /= Void
		do
			radio_group := a_list
		ensure
			assigned: radio_group = a_list
		end

	remove_radio_group is
			-- Set `radio_group' to `Void'.
		do
			radio_group := Void
		ensure
			void: radio_group = Void
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_SEPARATOR

end -- class EV_MENU_SEPARATOR_IMP

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

