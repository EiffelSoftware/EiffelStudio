indexing	
	description:
		"Menu item with state displayed as a circular check box.%N%
		%`is_selected' is mutually exclusive with respect to other radio menu%
		%items between separators in a menu."
	status: "See notice at end of class"
	keywords: "radio, item, menu, check, select, unselect"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_RADIO_MENU_ITEM

inherit
	EV_MENU_ITEM
		redefine
			implementation,
			create_implementation,
			is_in_default_state
		end

	EV_RADIO_PEER
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_SELECTABLE
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end
	
create
	default_create,
	make_with_text,
	make_with_text_and_action
	
feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
			-- Radio buttons are selected by default.
		do
			Result := Precursor {EV_MENU_ITEM}
				and then Precursor {EV_RADIO_PEER}
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_RADIO_MENU_ITEM_I
		-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_RADIO_MENU_ITEM_IMP} implementation.make (Current)
		end

end -- class EV_RADIO_MENU_ITEM

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------
