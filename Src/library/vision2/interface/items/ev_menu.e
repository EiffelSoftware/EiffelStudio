indexing
	description:
		"Drop down menu containing EV_MENU_ITEMs"
	status: "See notice at end of class"
	keywords: "menu, bar, drop down, popup"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU

inherit
	EV_MENU_ITEM
		undefine
			is_equal
		redefine
			implementation,
			create_implementation,
			is_in_default_state,
			parent
		end
	
	EV_MENU_ITEM_LIST
		undefine
			initialize
		redefine
			implementation,
			create_implementation,
			is_in_default_state
		end

create
	default_create,
	make_with_text,
	make_with_text_and_action

feature -- Status report

	parent: EV_MENU_ITEM_LIST is
			-- Menu item list containing `Current'.
			--| Redefined to avoid typing error.
		do
			Result := implementation.parent
		end

feature -- Standard operations

	show is
			-- Pop up on the current pointer position.
		require
			not_destroyed: not is_destroyed
		do
			implementation.show
		end

	show_at (a_widget: EV_WIDGET; a_x, a_y: INTEGER) is
			-- Pop up on `a_x', `a_y' relative to the top-left corner
			-- of `a_widget'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.show_at (a_widget, a_x, a_y)
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_MENU_ITEM} and Precursor {EV_MENU_ITEM_LIST}
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_MENU_I	
			-- Responsible for interaction with native graphics toolkit.
			
feature {NONE} -- Implementation
	
	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_MENU_IMP} implementation.make (Current)
		end

end -- class EV_MENU

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

